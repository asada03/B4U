//
//  AddAssetVC.swift
//  B4U Wallet
//
//  Created by Andres Luis Sada Govela on 03/02/18.
//  Copyright © 2018 Andres Luis Sada Govela. All rights reserved.
//

import UIKit

class AddAssetVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var addAssetButton: UIButton!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var delegate: HashgraphMessages!
    var walletId = ""
    var assetId = ""
    
    var images = [UIImage]()
    var imageIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        self.addAssetButton.layer.cornerRadius = 8.0
        self.addAssetButton.layer.masksToBounds = true
        self.addAssetButton.layer.borderWidth = 1.0

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y = -keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y = 0
        }
    }
    
    private func setImage() {
        let image = images[imageIndex]
//        var rotation:CGFloat = 0.0
//        
//        switch image.imageOrientation {
//        case .left:
//            rotation = -.pi/2
//            
//        case .right:
//            rotation = .pi/2
//
//        default:
//            rotation = 0.0
//        }
//        
//        let transform = CGAffineTransform.init(rotationAngle: rotation)
//        imageView.layer.setAffineTransform(transform)
        imageView.image = image
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "addImageSegue" {
            let destinationVC = segue.destination as? CameraVC
            
            destinationVC?.delegate = self
        }
    }

    // MARK: - Actions
    
    @IBAction func addAssetButtonPressed(_ sender: UIButton) {
        let message = "NA|\(assetId)|\(walletId)|\(titleTextField!.text!)|\(priceTextField!.text!)\n"
        let result = delegate!.messageToHashgraph(message)

        let resultArray = String(result[..<result.index(of: "\n")!]).components(separatedBy: "|")
        if resultArray.count >= 2 {
            if resultArray[0] == "NA" {
                delegate.setBalance(resultArray[1])
            }
            else if resultArray[0] == "ER" {
            }
        }

    }
    @IBAction func swipeImageLeft(_ sender: UISwipeGestureRecognizer) {
        if imageIndex + 1 < images.count {
            imageIndex += 1
            setImage()
        }
    }

    @IBAction func swipeImageRigt(_ sender: UISwipeGestureRecognizer) {
        if imageIndex - 1 >= 0 {
            imageIndex -= 1
            setImage()
        }
    }
}

extension AddAssetVC: AddImagesProtocol {
    func addImage(_ image: UIImage) {
        images.append(image)
        
        if imageView.image == nil {
            imageIndex = 0
            
            setImage()
        }
    }
}
