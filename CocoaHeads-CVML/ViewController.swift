//
//  ViewController.swift
//  CocoaHeads-CVML
//
//  Created by Jason Anderson on 9/23/18.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
//

import UIKit
import AVFoundation
import Stanley

class ViewController: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet private weak var previewView: PreviewView!
    @IBOutlet private weak var outputLabel: UILabel!
    
    //MARK:- Properties
    private enum SessionSetupResult {
        case success
        case notAuthorized
        case configurationFailed
    }
    private let sessionQueue = DispatchQueue(label: "session queue")
    private let videoOutputQueue = DispatchQueue(label: "video output queue")
    private let session = AVCaptureSession()
    private var isSessionRunning = false
    private var setupResult: SessionSetupResult = .success
    private var videoOutput = AVCaptureVideoDataOutput()
    private var videoDeviceInput: AVCaptureDeviceInput!
    private let viewModel: LiveCameraViewModel = LiveCameraViewModel()

    //MARK:- Lifecycle overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        previewView.session = session
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            break
            
        case .notDetermined:
            sessionQueue.suspend()
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { granted in
                if !granted {
                    self.setupResult = .notAuthorized
                }
                self.sessionQueue.resume()
            })
            
        default:
            setupResult = .notAuthorized
        }
        
        sessionQueue.async {
            self.configureSession()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sessionQueue.async {
            switch self.setupResult {
            case .success:
                self.session.startRunning()
                self.isSessionRunning = self.session.isRunning
                
            case .notAuthorized:
                KSTDispatchMainAsync {
                    let message = NSLocalizedString("PRIVACY_MESSAGE_CAMERA", tableName: nil, bundle: .main, value: "Hey, gimme access to your camera!", comment: "Alert message if user has not granted camera permissions")
                    let alertController = UIAlertController(title: "WTF, YO", message: message, preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: NSLocalizedString("ALERT_BUTTON_CANCEL", tableName: nil, bundle: .main, value: "Cancel", comment: "Button label to dismiss alert"), style: .cancel, handler: nil))
                    alertController.addAction(UIAlertAction(title: NSLocalizedString("ALERT_BUTTON_SETTINGS", tableName: nil, bundle: .main, value: "Settings", comment: "Button label to open settings"), style: .`default`, handler: { _ in
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                    }))
                    
                    self.present(alertController, animated: true, completion: nil)
                }
                
            case .configurationFailed:
                KSTDispatchMainAsync {
                    let message = NSLocalizedString("ERROR_MESSAGE_CAPTURE_SESSION", tableName: nil, bundle: .main, value: "Camera was unable to capture any data", comment: "Alert message when camera configuration unable to capture data")
                    let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: NSLocalizedString("ALERT_BUTTON_OK", tableName: nil, bundle: .main, value: "OK", comment: "Button label to dismiss alert"), style: .cancel, handler: nil))
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        sessionQueue.async {
            if self.setupResult == .success {
                self.session.stopRunning()
                self.isSessionRunning = self.session.isRunning
            }
        }
        
        super.viewWillDisappear(animated)
    }

}

//MARK:- Private methods
private extension ViewController {
    func configureSession() {
        if setupResult != .success {
            return
        }
        
        session.beginConfiguration()
        
        session.sessionPreset = .high
        
        do {
            var defaultVideoDevice: AVCaptureDevice?
            
            if let dualCameraDevice = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back) {
                defaultVideoDevice = dualCameraDevice
            } else if let backCameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
                defaultVideoDevice = backCameraDevice
            }
            
            let videoDeviceInput = try AVCaptureDeviceInput(device: defaultVideoDevice!)
            
            if session.canAddInput(videoDeviceInput) {
                session.addInput(videoDeviceInput)
                self.videoDeviceInput = videoDeviceInput
                
                KSTDispatchMainAsync {
                    let statusBarOrientation = UIApplication.shared.statusBarOrientation
                    var initialVideoOrientation: AVCaptureVideoOrientation = .portrait
                    if statusBarOrientation != .unknown {
                        if let videoOrientation = AVCaptureVideoOrientation(rawValue: statusBarOrientation.rawValue) {
                            initialVideoOrientation = videoOrientation
                        }
                    }
                    
                    self.previewView.videoPreviewLayer.connection?.videoOrientation = initialVideoOrientation
                }
            } else {
                print("Could not add video device input to the session")
                setupResult = .configurationFailed
                session.commitConfiguration()
            }
        } catch {
            print("Could not create video device input: \(error)")
            setupResult = .configurationFailed
            session.commitConfiguration()
            return
        }
        
        if session.canAddOutput(videoOutput) {
            session.addOutput(videoOutput)
            
            videoOutput.alwaysDiscardsLateVideoFrames = true
            videoOutput.setSampleBufferDelegate(self, queue: videoOutputQueue)
            if let videoConnection = videoOutput.connection(with: .video) {
                videoConnection.isEnabled = true
                
                if videoConnection.isCameraIntrinsicMatrixDeliverySupported {
                    videoConnection.isCameraIntrinsicMatrixDeliveryEnabled = true
                }
            }
            
        } else {
            print("Could not add photo output to the session")
            setupResult = .configurationFailed
            session.commitConfiguration()
            return
        }
        
        session.commitConfiguration()
    }
    
    func appliedOrientationForVideoPreviewOrientation(_ orientation: AVCaptureVideoOrientation) -> CGImagePropertyOrientation {
        switch orientation {
        case .portrait: return CGImagePropertyOrientation.right;
        case .landscapeLeft: return CGImagePropertyOrientation.down;
        case .portraitUpsideDown: return CGImagePropertyOrientation.left;
        case .landscapeRight: return CGImagePropertyOrientation.up;
        }
    }
    
}

//MARK:- AVCaptureVideoDataOutputSampleBufferDelegate methods
extension ViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        let image = CIImage(cvPixelBuffer: pixelBuffer)
        KSTDispatchMainAsync {
            if let orientation = self.previewView.videoPreviewLayer.connection?.videoOrientation {
                let appliedOrientation = self.appliedOrientationForVideoPreviewOrientation(orientation)
                self.sessionQueue.async {
                    let rotatedImage = image.oriented(appliedOrientation)
                    self.viewModel.performDetectionOnImage(rotatedImage, withOrientation: appliedOrientation, withCompletion: { (confidence, label) in
                        if let label = label {
                            if (confidence > 98.0) {
                                self.outputLabel.text = label
                            }
                        }
                    })
                }
            }
        }
    }
}
