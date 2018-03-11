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
    
    var originalX:CGFloat = 0.0
    var secondX:CGFloat = 0.0
    
    lazy var secondImage = UIImageView(frame: self.bounds)

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
        secondImage.contentMode = .scaleAspectFit
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeImageLeft))
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeImageRigt))
        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.panImage))
        
        swipeLeft.direction = .left
        swipeRight.direction = .right
        
//        swipeLeft.delegate = self
//        swipeRight.delegate = self
//        pan.delegate = self
        
        addGestureRecognizer(swipeLeft)
        addGestureRecognizer(swipeRight)
        addGestureRecognizer(pan)
        
        self.addSubview(secondImage)
    }

    private func setImage(toRight:Bool) {
        if toRight {
            if imageIndex - 1 >= 0 {
                imageIndex -= 1
                setImage()
            }
        }
        else {
            if imageIndex + 1 < images.count {
                imageIndex += 1
                setImage()
            }

        }
    }

    @objc func swipeImageLeft(_ sender: UISwipeGestureRecognizer) {
        setImage(toRight: false)
    }
    
    @objc func swipeImageRigt(_ sender: UISwipeGestureRecognizer) {
        setImage(toRight: true)
    }
    
    @objc func panImage(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.superview!)
        
        if recognizer.state == .began {
            self.secondImage.isHidden = false
            self.secondImage.alpha = 1.0
            
            
            if translation.x > 0 {
                self.secondImage.frame = self.bounds
                self.secondImage.frame.origin.x = -self.frame.size.width - self.frame.origin.x
                if (imageIndex > 0) {
                    self.secondImage.image = self.images[imageIndex - 1]
                }
            }
            else {
                self.secondImage.frame = self.bounds
                self.secondImage.frame.origin.x = self.frame.size.width + self.frame.origin.x
                if (imageIndex < images.count - 1) {
                    self.secondImage.image = self.images[imageIndex + 1]
                }
            }
            
            originalX = self.frame.origin.x
            secondX = secondImage.frame.origin.x
        }
        
        self.frame.origin.x += translation.x
        
        if recognizer.state == .ended {
            //var x:CGFloat = self.backgroundView.frame.origin.x
            let diff = abs(self.originalX - self.frame.origin.x)
            if (diff < self.frame.size.width / 2) {
                UIView.animate(withDuration: 0.4,
                               delay: 0,
                               options: UIViewAnimationOptions.curveEaseOut,
                               animations: {
                                self.frame.origin.x = self.originalX
                                self.secondImage.alpha = 0
                                },
                               completion: {  (value: Bool) in
                                
                                    self.secondImage.isHidden = true
                                })
                
            }
            else {
                UIView.animate(withDuration: 0.4,
                               delay: 0,
                               options: UIViewAnimationOptions.curveEaseOut,
                               animations: {
                                self.frame.origin.x = -self.secondX
                },
                               completion: {  (value: Bool) in
                                self.setImage(toRight: self.secondX < 0)
                                self.frame.origin.x = self.originalX
                                self.secondImage.isHidden = true
                })
            }
            
        }

        recognizer.setTranslation(CGPoint.zero, in: self)
    }
}

extension CarrouselImageView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer)
        -> Bool {
            return true
    }
}
