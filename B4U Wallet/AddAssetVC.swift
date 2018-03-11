//
//  AddAssetVC.swift
//  B4U Wallet
//
//  Created by Andres Luis Sada Govela on 03/02/18.
//  Copyright © 2018 Andres Luis Sada Govela. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class AddAssetVC: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var addAssetButton: UIButton!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var keyboardHeightViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var carrouselImageView: CarrouselImageView!
    
    var activeTextField = UITextField()
    
    var delegate: HashgraphMessages!
    var walletId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)

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
            let offset = min (carrouselImageView.frame.size.height, keyboardSize.height)
            self.view.frame.origin.y = -offset
            keyboardHeightViewConstraint.constant = max (keyboardHeightViewConstraint.constant, keyboardSize.height - offset)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y = 0
        }
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
        activeTextField.endEditing(true)
        let ref = Database.database().reference()

        
        let price: Float = {
            guard let val = Float(priceTextField.text!) else { return 0.0 }
            return val
        }()
        
        let assetData = ["title": titleTextField.text!,
            "description": descriptionTextView.text,
            "price": price,
            "wallet": walletId
            ] as [String : Any]
        let assetId = ref.child("Assets").childByAutoId()
        
        print ("id: \(assetId.key)")
        assetId.setValue(assetData)

        let storage = Storage.storage().reference().child(assetId.key)

        for i in carrouselImageView.images.indices {
            let imageStorageRef = storage.child("\(i).jpg")
            let image = carrouselImageView.images[i]
            if let data:Data = UIImageJPEGRepresentation(image, 1.0) {
                // Handle operations with data here...
                let _ = imageStorageRef.putData(data, metadata: nil) { (metadata, error) in
                    guard let metadata = metadata else {
                        // Uh-oh, an error occurred!
                        return
                    }
                    // Metadata contains file metadata such as size, content-type, and download URL.
                    let downloadURL = metadata.downloadURL
                    print (">>>>downloadURL:\(downloadURL()!.absoluteString)")
                }
            }

        }
        let message = "NA|\(assetId.key)|\(walletId)|\(titleTextField!.text!)|\(priceTextField!.text!)\n"
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
}

extension AddAssetVC: AddImagesProtocol {
    func addImage(_ image: UIImage) {
        carrouselImageView.addImage(image)
    }
}

extension AddAssetVC : UITextFieldDelegate {
    
    // Assign the newly active text field to your activeTextField variable
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.activeTextField = textField
    }
    
}
