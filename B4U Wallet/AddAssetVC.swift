//
//  AddAssetVC.swift
//  B4U Wallet
//
//  Created by Andres Luis Sada Govela on 03/02/18.
//  Copyright © 2018 Andres Luis Sada Govela. All rights reserved.
//

import UIKit

class AddAssetVC: UIViewController {

    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var addAssetButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    
    var delegate: HashgraphMessages!
    var walletId = ""
    var assetId = ""

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - Actions
    
    @IBAction func addAssetButtonPressed(_ sender: UIButton) {
        let message = "NA|\(assetId)|\(walletId)|\(descriptionTextField!.text!)|\(priceTextField!.text!)\n"
        let result = delegate!.messageToHashgraph(message)

        let resultArray = String(result[..<result.index(of: "\n")!]).components(separatedBy: "|")
        if resultArray.count >= 2 {
            if resultArray[0] == "NA" {
                delegate.setBalance(resultArray[1])
                messageLabel!.text = "Transferencia Exitosa"
            }
            else if resultArray[0] == "ER" {
                messageLabel!.text = resultArray[1]
            }
        }

    }
}
