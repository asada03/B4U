//
//  CarrouselImageView.swift
//  B4U Wallet
//
//  Created by Andres Luis Sada Govela on 09/03/18.
//  Copyright © 2018 Andres Luis Sada Govela. All rights reserved.
//

import UIKit

class CarrouselImageView: UIImageView {

    var images = [UIImage]()
    var imageIndex = 0
    var isImageSet = false

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func addImage(_ image: UIImage) {
        images.append(image)
        
        if isImageSet == false {
            isImageSet = true
            imageIndex = 0
            
            setImage()
        }
    }
    
    private func setImage() {
        image = images[imageIndex]
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        isUserInteractionEnabled = true
        contentMode = .scaleAspectFit
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeImageLeft))
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeImageRigt))

        swipeLeft.direction = .left
        swipeRight.direction = .right
        
        addGestureRecognizer(swipeLeft)
        addGestureRecognizer(swipeRight)
    }


    @objc func swipeImageLeft(_ sender: UISwipeGestureRecognizer) {
        if imageIndex + 1 < images.count {
            imageIndex += 1
            setImage()
        }
    }
    
    @objc func swipeImageRigt(_ sender: UISwipeGestureRecognizer) {
        if imageIndex - 1 >= 0 {
            imageIndex -= 1
            setImage()
        }
    }

}
