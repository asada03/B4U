//
//  ViewController.swift
//  B4U Wallet
//
//  Created by Andres Luis Sada Govela on 20/01/18.
//  Copyright © 2018 Andres Luis Sada Govela. All rights reserved.
//

import UIKit
import FirebaseDatabase

protocol HashgraphMessages {
    func messageToHashgraph(_ message: String) -> String
    func setInfo(name:String, id:String, balance:String)
    func setBalance(_ balance:String)
}

class ViewController: UIViewController, HashgraphMessages {

    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var qrImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var paymentButton: UIButton!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var addAssetButton: UIButton!
    @IBOutlet weak var balanceCheckButton: UIButton!
    @IBOutlet weak var walletIdLabel: UILabel!
    
    var qrImage: CIImage!
    lazy var ref = Database.database().reference()
    
    
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
        
        self.balanceCheckButton.layer.cornerRadius = 8.0
        self.balanceCheckButton.layer.masksToBounds = true
        self.balanceCheckButton.layer.borderWidth = 1.0
        
        self.qrImageView.layer.borderWidth = 1.0
        
        let accountID = HGCAccountID(shardId: 0, realmId: 0, accountId: 1001)
        var fromAccount = HGCAccount()
        fromAccount.updateAccountID(accountID)
        let tokent = SKToken()
        
        self.getHederaAccountInfo(fromAccount:fromAccount, toAccount:fromAccount, toAccountName:"Andres", ammount:10, notes:"Hola", token:token, gas:10)
    }
    
    func getHederaAccountInfo(fromAccount:HGCAccount, toAccount:HGCAccountID, toAccountName:String?, amount:UInt64, notes:String?, token:SCToken, gas:UInt64) {
        
        
        var base = BaseOperation().type(of: init)()
        base.node = HGCNodeV0.init("testnet41.hedera.com: 80",
                                   HGCAccountID(shardId: 0, realmId: 0, accountId: 3))
        var cryptoClient = base.cryptoClient
        

        let req = APIRequestBuilder.requestForGetAccountInfo(fromAccount: fromAccount, accountID: toAccount, node.accountID)
        do {
            let infoResponse = try cryptoClient.getAccountInfo(req)
            print(infoResponse.textFormatString())
            if infoResponse.cryptoGetInfo.hasAccountInfo {
            }
            else {
                errorMessage = "Unable to fetch accountInfo"
            }
        }
        catch {
            errorMessage = "Someting went wrong, Please try later"
        }
    }

    func hederaAccountBalance(forAccount:HGCAccount, toAccount:HGCAccountID, toAccountName:String?, amount:UInt64, notes:String?, token:SCToken, gas:UInt64) {
        let req = APIRequestBuilder.requestForGetAccountInfo(fromAccount: fromAccount, node: node.accountID)
        do {
            let infoResponse = try cryptoClient.getAccountInfo(req)
            Logger.instance.log(message: infoResponse.textFormatString(), event: .i)
            if infoResponse.cryptoGetInfo.hasAccountInfo {
            }
            else {
                errorMessage = "Unable to fetch accountInfo"
            }
        }
        catch {
            errorMessage = "Someting went wrong, Please try later"
        }
    }
    
    func getBalance() {
        let RemoteHost = "testnet41.hedera.com"
        
        let request = RMTSimpleRequest()
        request.responseSize = 10
        request.fillUsername = true
        request.fillOauthScope = true
        
        
        // Example gRPC call using a generated proto client library:
        
        let service = RMTTestService(host: RemoteHost)
        service.unaryCall(with: request) { response, error in
            if let response = response {
                NSLog("1. Finished successfully with response:\n\(response)")
            } else {
                NSLog("1. Finished with error: \(error!)")
            }
        }
        
        
        // Same but manipulating headers:
        
        var RPC : GRPCProtoCall! // Needed to convince Swift to capture by reference (__block)
        RPC = service.rpcToUnaryCall(with: request) { response, error in
            if let response = response {
                NSLog("2. Finished successfully with response:\n\(response)")
            } else {
                NSLog("2. Finished with error: \(error!)")
            }
            NSLog("2. Response headers: \(RPC.responseHeaders)")
            NSLog("2. Response trailers: \(RPC.responseTrailers)")
        }
        
        // TODO(jcanizales): Revert to using subscript syntax once XCode 8 is released.
        RPC.requestHeaders["My-Header"] = "My value"
        
        RPC.start()
        
        
        // Same example call using the generic gRPC client library:
        
        let method = GRPCProtoMethod(package: "grpc.testing", service: "TestService", method: "UnaryCall")!
        
        let requestsWriter = GRXWriter(value: request.data())
        
        let call = GRPCCall(host: RemoteHost, path: method.httpPath, requestsWriter: requestsWriter)!
        
        call.requestHeaders["My-Header"] = "My value"
        
        call.start(with: GRXWriteable { response, error in
            if let response = response as? Data {
                NSLog("3. Received response:\n\(try! RMTSimpleResponse(data: response))")
            } else {
                NSLog("3. Finished with error: \(error!)")
            }
            NSLog("3. Response headers: \(call.responseHeaders)")
            NSLog("3. Response trailers: \(call.responseTrailers)")
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if nameLabel != nil, walletIdLabel != nil {
            print("putting -\(walletIdLabel!.text!)|\(nameLabel!.text!)- into code")
            let data = "\(walletIdLabel!.text!)|\(nameLabel!.text!)".data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
            
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
        
        //ref.child("pelos").setValue(["username": "Pepe"])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if walletIdLabel!.text == "id" {
            self.performSegue(withIdentifier: "newAccountSegue", sender: self)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
        else if segue.identifier == "paySegue" {
            let destViewController = segue.destination as! PayVC
            destViewController.delegate = self
            destViewController.walletId = walletIdLabel!.text!
        }
        else if segue.identifier == "addAssetSegue" {
            let destViewController = segue.destination as! AddAssetVC
            destViewController.delegate = self
            destViewController.walletId = walletIdLabel!.text!
        }
        else if segue.identifier == "buyAssetSegue" {
            let destViewController = segue.destination as! BuyAssetTVC
            destViewController.walletId = walletIdLabel!.text!
            destViewController.delegate = self
        }
    }

    // MARK: HashgraphMessages delegate
    func messageToHashgraph(_ message: String) -> String {
        let port: Int32 = 64105
        let client = TCPClient(address: "192.168.1.64", port: port)
        
        print ("sending message:\(message)")
        
        switch client.connect(timeout: 1) {
        case .success:
            switch client.send(string:message) {
            case .success:
                guard let data = client.read(1024*10, timeout: 10) else {
                    return "ER|1\n"}
                
                if let response = String(bytes: data, encoding: .utf8) {
                    print("response: \(response)");
                    client.close()
                    return response
                }
            case .failure(let error):
                print(error)
                return "ER|2\n"
            }
        case .failure(let error):
            print(error)
            return "ER|3\n"
        }
        
        return "ER|4\n"
    }
    
    func setInfo(name: String, id: String, balance: String) {
        nameLabel!.text = name
        walletIdLabel!.text = id
        setBalance(balance)
    }

    func setBalance(_ balance: String) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        balanceLabel!.text = numberFormatter.string(from: NSNumber(value:Int(balance)!))
    }

    // MARK: Actions
    @IBAction func balanceCheckButtonPressed(_ sender: UIButton) {
        let message = "BC|\(walletIdLabel!.text!)\n"
        let result = messageToHashgraph(message)
        
        let resultArray = String(result[..<result.index(of: "\n")!]).components(separatedBy: "|")
        if resultArray.count >= 2 {
            if resultArray[0] == "BC" {
                setBalance(resultArray[1])
            }
            else if resultArray[0] == "ER" {
                // create the alert
                let alert = UIAlertController(title: "Error", message: "Hubo un error de comunicación. Verifique su conexión a Internet e intente de nuevo.", preferredStyle: UIAlertControllerStyle.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
}
