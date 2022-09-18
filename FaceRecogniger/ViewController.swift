//
//  ViewController.swift
//  FaceRecogniger
//
//  Created by Вячеслав Квашнин on 18.09.2022.
//

import UIKit
import Vision

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let image = UIImage(named: "photo") else { return }
        
        let imageView = UIImageView(image: image)
        let scaleHeight = view.frame.width / image.size.width * image.size.height
        imageView.contentMode = .scaleAspectFit
        
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: scaleHeight)
        view.addSubview(imageView)
        
        let request = VNDetectFaceRectanglesRequest { request, error in

    request.usesCPUOnly = true
  
            if error != nil {
                print("ERROR")
                return
            }
            request.results?.forEach({ res in
                DispatchQueue.main.async {
                    print(res)
                }
            })
        }
        
        guard let cgImage = image.cgImage else { return }
        
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        do {
            try handler.perform([request])
        } catch let reqError {
            print(reqError)
        }

    }

}

