//
//  LiveCameraViewModel.swift
//  CocoaHeads-CVML
//
//  Created by Jason Anderson on 11/1/18.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
//

import UIKit
import Vision
import CoreML
import Stanley

class LiveCameraViewModel: NSObject {
    func performDetectionOnImage(_ image: CIImage, withOrientation orientation: CGImagePropertyOrientation, withCompletion completion: @escaping (_ confidence: Float, _ identifier: String?) -> Void) {
        guard let model = try? VNCoreMLModel(for: ImageClassifier().model) else {
            completion(0.0, nil)
            return
        }
        let request = VNCoreMLRequest(model: model) { (request, error) in
            if let results = request.results as? [VNClassificationObservation] {
                if let result = results.first {
                    KSTDispatchMainAsync {
                        let confidence = result.confidence * 100
                        let label = result.identifier
                        completion(confidence, label)
                    }
                }
            }
        }
        let handler = VNImageRequestHandler(ciImage: image, orientation: orientation, options: [:])
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try handler.perform([request])
            } catch {
                print(error)
            }
        }
    }
}
