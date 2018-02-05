//
//  CreateAccountVC.swift
//  B4U Wallet
//
//  Created by Andres Luis Sada Govela on 31/01/18.
//  Copyright © 2018 Andres Luis Sada Govela. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    
    var delegate: HashgraphMessages!
    var walletId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.createButton.layer.cornerRadius = 8.0
        self.createButton.layer.masksToBounds = true
        self.createButton.layer.borderWidth = 1.0

        self.messageLabel.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    @IBAction func CreateButtonPressed(_ sender: UIButton) {
        if delegate != nil {
            messageLabel.text = "Creando Cuenta"
            let message = "NW|\(nameTextField.text!)|\(walletId)\n"
            let result = delegate!.messageToHashgraph(message)
            messageLabel.text = result;
            
            let resultArray = String(result[..<result.index(of: "\n")!]).components(separatedBy: "|")
            if resultArray.count >= 3 {
                if resultArray[0] == "NW" {
                    delegate.setInfo(name: nameTextField!.text!, id: resultArray[1], balance: resultArray[2])
                }
            }
        }
    }
}
