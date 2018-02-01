//
//  ViewController.swift
//  B4U Wallet
//
//  Created by Andres Luis Sada Govela on 20/01/18.
//  Copyright © 2018 Andres Luis Sada Govela. All rights reserved.
//

import UIKit

protocol HashgraphMessages {
    func messageToHashgraph(_ message: String) -> String
    func setInfo(name:String, id:String, balance:String)
}

class ViewController: UIViewController, HashgraphMessages {

    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var qrImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var paymentButton: UIButton!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var addAssetButton: UIButton!
    @IBOutlet weak var walletIdLabel: UILabel!
    
    var qrImage: CIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.paymentButton.layer.cornerRadius = 8.0
        self.paymentButton.layer.masksToBounds = true
        self.paymentButton.layer.borderWidth = 1.0
        
        self.buyButton.layer.cornerRadius = 8.0
        self.buyButton.layer.masksToBounds = true
        self.buyButton.layer.borderWidth = 1.0
        
        self.addAssetButton.layer.cornerRadius = 8.0
        self.addAssetButton.layer.masksToBounds = true
        self.addAssetButton.layer.borderWidth = 1.0
        
        self.qrImageView.layer.borderWidth = 1.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if nameLabel != nil, walletIdLabel != nil {
            let data = "\(walletIdLabel!.text!)|\(nameLabel!.text)".data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
            
            let filter = CIFilter(name: "CIAztecCodeGenerator")!
            
            filter.setValue(data, forKey: "inputMessage")

            let transform = CGAffineTransform(scaleX: qrImageView.frame.size.width / filter.outputImage!.extent.size.width,
                                                   y: qrImageView.frame.size.height / filter.outputImage!.extent.size.height)
            if let output = filter.outputImage?.transformed(by:transform) {
                let uiImage = UIImage(ciImage: output)
                
                print ("image:\(uiImage.size.width), \(uiImage.size.height)")
                qrImageView.image = uiImage
            }
        }

        self.navigationController?.isNavigationBarHidden = true

    }
    
    override func viewDidAppear(_ animated: Bool) {
        if walletIdLabel!.text == "id" {
            self.performSegue(withIdentifier: "newAccountSegue", sender: self)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newAccountSegue" {
            let destViewController = segue.destination as! CreateAccountVC
            destViewController.delegate = self
            destViewController.walletId = "\(Int(arc4random_uniform(10000000)))"
        }
    }

    // MARK: HashgraphMessages delegate
    func messageToHashgraph(_ message: String) -> String {
        let port: Int32 = 64104
        let client = TCPClient(address: "192.168.1.64", port: port)
        
        print ("sending message:\(message)")
        
        switch client.connect(timeout: 1) {
        case .success:
            switch client.send(string:message) {
            case .success:
                guard let data = client.read(1024*10, timeout: 10) else {
                    return "ERR"}
                
                if let response = String(bytes: data, encoding: .utf8) {
                    print("response: \(response)");
                    client.close()
                    return response
                }
            case .failure(let error):
                print(error)
                return "ERR"
            }
        case .failure(let error):
            print(error)
            return "ERR"
        }
        
        return "ERR"
    }
    
    func setInfo(name: String, id: String, balance: String) {
        nameLabel!.text = name
        walletIdLabel!.text = id
        balanceLabel!.text = balance
    }

    // MARK: Actions
    @IBAction func createAccountButtonPressed(_ sender: UIButton) {
    }
}
