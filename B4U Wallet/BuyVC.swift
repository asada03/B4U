//
//  BuyVC.swift
//  B4U Wallet
//
//  Created by Andres Luis Sada Govela on 05/02/18.
//  Copyright © 2018 Andres Luis Sada Govela. All rights reserved.
//

import UIKit

class BuyVC: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ammountLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    
    var delegate: HashgraphMessages!
    var walletId = ""
    var asset:B4UAsset!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.buyButton.layer.cornerRadius = 8.0
        self.buyButton.layer.masksToBounds = true
        self.buyButton.layer.borderWidth = 1.0
        
        descriptionLabel.text = asset != nil ? asset.description : ""
        ammountLabel.text = asset != nil ? asset.ammount : ""
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

    @IBAction func buyButtonPressed(_ sender: UIButton) {
        let message = "BA|\(walletId)|\(asset!.key)\n"
        let result = delegate!.messageToHashgraph(message)
        
        let resultArray = String(result[..<result.index(of: "\n")!]).components(separatedBy: "|")
        if resultArray.count >= 2 {
            if resultArray[0] == "BA" {
                delegate.setBalance(resultArray[1])
                descriptionLabel!.text = "Compra Exitosa"
            }
            else if resultArray[0] == "ER" {
                descriptionLabel!.text = resultArray[1]
            }
        }

    }
}
