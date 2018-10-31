//
//  PreviewView.swift
//  CocoaHeads-CVML
//
//  Created by Jason Anderson on 10/31/18.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
//

import UIKit
import AVFoundation

class PreviewView: UIView {

    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        guard let layer = layer as? AVCaptureVideoPreviewLayer else {
            fatalError("Expected `AVCaptureVideoPreviewLayer` type for layer")
        }
        
        return layer
    }
    
    var session: AVCaptureSession? {
        get {
            return videoPreviewLayer.session
        }
        set {
            videoPreviewLayer.session = newValue
        }
    }
    
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }

}
