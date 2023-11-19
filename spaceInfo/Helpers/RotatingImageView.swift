//
//  RotatingImageView.swift
//  spaceInfo
//
//  Created by Saba Gogrichiani on 19.11.23.
//

import UIKit

final class RotatingImageView: UIImageView {

    private var rotation: CABasicAnimation?

    func startRotating(duration: Double = 1) {
        if self.layer.animation(forKey: "rotationAnimation") == nil {
            rotation = CABasicAnimation(keyPath: "transform.rotation.z")
            rotation?.toValue = NSNumber(value: Double.pi * 2)
            rotation?.duration = duration
            rotation?.isCumulative = true
            rotation?.repeatCount = Float.greatestFiniteMagnitude
            self.layer.add(rotation!, forKey: "rotationAnimation")
        }
    }

    func stopRotating() {
        if self.layer.animation(forKey: "rotationAnimation") != nil {
            self.layer.removeAnimation(forKey: "rotationAnimation")
            DispatchQueue.main.async {
                self.isHidden = true

            }
        }
    }
}

