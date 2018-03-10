//
//  BuyVC.swift
//  B4U Wallet
//
//  Created by Andres Luis Sada Govela on 05/02/18.
//  Copyright © 2018 Andres Luis Sada Govela. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class BuyVC: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ammountLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var carrouselImageView: CarrouselImageView!
    
    var delegate: HashgraphMessages!
    var walletId = ""
    var asset:DataSnapshot!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.buyButton.layer.cornerRadius = 8.0
        self.buyButton.layer.masksToBounds = true
        self.buyButton.layer.borderWidth = 1.0
        
        if let value = asset?.value as? Dictionary<String,Any> {
            descriptionLabel.text = value["description"] as? String? ?? ""
            titleLabel.text = value["title"] as? String? ?? ""
            ammountLabel.text = "\(value["price"] as? Float ?? 0.0)"
        }
        
        loadImage(0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadImage(_ num:Int) {
        let pathReference = Storage.storage().reference(withPath: "\(asset!.key)/\(num).jpg")
        
        // Download in memory with a maximum allowed size of 4MB (4 * 1024 * 1024 bytes)
        pathReference.getData(maxSize: 4_194_304) { data, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let image = UIImage(data: data!) {
                    self.carrouselImageView.addImage(image)
                    self.loadImage(num+1)
                }
            }
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
