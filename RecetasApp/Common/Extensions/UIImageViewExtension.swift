//
//  UIImageViewExtension.swift
//  RecetasApp
//
//  Created by Daniel Duran Schutz on 3/05/23.
//

import Foundation
import UIKit

extension UIImageView {
    func setImageFromUrl(imageUrl:String = String("")){
        if imageUrl == "" {
            self.image = UIImage(named: "placeholder")
        }else{
            let url = URL(string: imageUrl)
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url!){
                    DispatchQueue.main.async {
                        self.image = UIImage(data: data)
                    }
                }
            }
        }
    }
    
    func enableZoom() {
      let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startZooming(_:)))
      isUserInteractionEnabled = true
      addGestureRecognizer(pinchGesture)
    }

    @objc private func startZooming(_ sender: UIPinchGestureRecognizer) {
      let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
      guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
      sender.view?.transform = scale
      sender.scale = 1
    }
}
