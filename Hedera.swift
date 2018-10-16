import UIKit
//import web3swift
//import Geth
//import CryptoSwift
import SwiftProtobuf
import Foundation


class BaseOperation: Operation {
    var errorMessage:String?
    var node:HGCNodeVO!
    
    override func main() {
        node = APIAddressBookService.defaultAddressBook.randomNode()
        print(" >>> \(node.address())", event: .i)
    }
    
    var cryptoClient: Proto_CryptoServiceServiceClient {
        return Proto_CryptoServiceServiceClient.init(address: node.address(), secure: false)
    }
}

class SKToken: Operation {
    
}

// asld+

//class APIAddressBookService {
//    static let defaultAddressBook : APIAddressBookService = APIAddressBookService.init();
//    private var hash : String?
//    private var nodes = [HGCNodeVO]()
//    
//    init() {
//        loadList()
//    }
//    
//    func loadList() {
//        let list = getList()
//        nodes = list.map({ (node) -> HGCNodeVO in
//            return node.nodeVO()
//        })
//    }
//    
//    private func getList() -> [HGCNode] {
//        var nodes = HGCNode.getAllNodes(activeOnly: true)
//        if nodes.count <= 0 {
//            loadListFromFile()
//            nodes = HGCNode.getAllNodes(activeOnly: true)
//        }
//        return nodes
//    }
//    
//    private func loadListFromFile() {
//        let url = Bundle.main.url(forResource: nodeListFileName, withExtension: "json")
//        do {
//            let data = try NSData(contentsOf: url!, options: NSData.ReadingOptions())
//            let object = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments)
//            if let items = object as? [[String : Any]] {
//                items.forEach { (map) in
//                    if let node = HGCNodeVO.init(map:map) {
//                        nodes.append(node)
//                        HGCNode.addNode(nodeVO: node)
//                    }
//                }
//                CoreDataManager.shared.saveContext()
//            }
//        } catch {
//            
//        }
//    }
//    
//    func randomNode() -> HGCNodeVO {
//        if nodes.count > 0 {
//            let index = Int(arc4random_uniform(UInt32(nodes.count)))
//            if index >= 0 && index < nodes.count {
//                return nodes[index]
//            }
//        }
//        return HGCNode.getAllNodes(activeOnly: false).first!.nodeVO()
//    }
//    
//}

class HGCNodeVO {
    let host: String
    let port: Int32
    let accountID:HGCAccountID
    
    init(host:String, port:Int32, accountID:HGCAccountID) {
        self.host = host
        self.port = port
        self.accountID = accountID
    }
    
    init?(map:[String:Any]) {
        let json = JSON(map)
        self.host = json["host"].stringValue
        self.port = json["port"].int32Value
        self.accountID = HGCAccountID.init(shardId: json["shardNum"].int64Value, realmId: json["realmNum"].int64Value, accountId: json["accountNum"].int64Value)
    }
    
    func address() -> String {
        return host + ":" + port.description
    }
}

// asg asg usage example

class TokenTransferOperation: BaseOperation {
    let fromAccount: HGCAccount
    let toAccount: HGCAccountID
    let token: SCToken
    let toAccountName: String?
    let amount:UInt64
    let gas:UInt64
    let notes:String?
    
    init(fromAccount:HGCAccount, toAccount:HGCAccountID, toAccountName:String?, amount:UInt64, notes:String?, token:SCToken, gas:UInt64) {
        self.fromAccount = fromAccount
        self.toAccount = toAccount
        self.toAccountName = toAccountName
        self.amount = amount
        self.notes = notes
        self.token = token
        self.gas = gas
    }
    
    override func transferToken(fromAccount:HGCAccount, toAccount:HGCAccountID, toAccountName:String?, amount:UInt64, notes:String?, token:SCToken, gas:UInt64) {
        super.main()
        let req = APIRequestBuilder.requestForGetAccountInfo(fromAccount: fromAccount, node: node.accountID)
        do {
            let infoResponse = try cryptoClient.getAccountInfo(req)
            Logger.instance.log(message: infoResponse.textFormatString(), event: .i)
            if infoResponse.cryptoGetInfo.hasAccountInfo {
                let contractAccID = infoResponse.cryptoGetInfo.accountInfo.contractAccountID
                do {
                    let r = APIRequestBuilder.requestForTransferOnContract(fromAccount: fromAccount, ethToAddress: contractAccID, amount: Int64(amount), contract: token.token(), gas: gas, notes: notes, node: node.accountID)
                    Logger.instance.log(message: r.textFormatString(), event: .i)
                    
                    let t = try tokenClient.contractCallMethod(r)
                    Logger.instance.log(message: t.textFormatString(), event: .i)
                    
                    switch t.nodeTransactionPrecheckCode {
                    case .ok:
                        onTransferSuccess(txn:r)
                        
                    case .invalidTransaction:
                        errorMessage = "Invalid transaction"
                    case .invalidAccount:
                        errorMessage = "Invalid account"
                    case .insufficientFee:
                        errorMessage = "Insufficient fee"
                    case .insufficientBalance:
                        errorMessage = "Insufficient balance"
                    case .duplicate:
                        errorMessage = "Duplicate transaction"
                    case .UNRECOGNIZED(_):
                        errorMessage = "Transaction Precheck Failed"
                    }
                    
                } catch {
                    Logger.instance.log(message: error.desc(), event: .e)
                    errorMessage = "Someting went wrong, Please try later"
                }
            } else {
                errorMessage = "Unable to fetch accountInfo"
            }
            
            
        }
        catch {
            errorMessage = "Someting went wrong, Please try later"
        }
    }
    
    func onTransferSuccess(txn: Proto_Transaction) {
        fromAccount.createTransaction(toAccountID: self.toAccount, txn:txn)
        HGCContact.addAlias(name: self.toAccountName, address: self.toAccount.stringRepresentation())
        CoreDataManager.shared.saveContext()
    }
}
//asga sga

struct HGCPublickKeyAddress {
    static let lengthEC = 97
    static let lengthED = 32
    static let lengthRSA = 613
    
    var publicKeyData:Data
    var type: SignatureOption
    
    static func extractData(data: Data) -> (type:SignatureOption?, data:Data?) {
        if let t = HGCPublickKeyAddress.getType(publicKeyData: data) {
            var length = 0
            switch t {
            case .ECDSA:
                length = HGCPublickKeyAddress.lengthEC
            case .ED25519:
                length = HGCPublickKeyAddress.lengthED
            case .RSA:
                length = HGCPublickKeyAddress.lengthRSA
            }
            if data.count == length  {
                return(t,data)
            }else {
                return (nil,nil)
            }
        } else {
            return (nil,nil)
        }
    }
    
    init?(publicKeyData:Data, type: SignatureOption) {
        if let data = HGCPublickKeyAddress.extractData(data: publicKeyData).data {
            self.publicKeyData = data
            self.type = type
        } else {
            return nil
        }
    }
    
    init?(data:Data) {
        let result = HGCPublickKeyAddress.extractData(data: data)
        if let d = result.data, let t = result.type  {
            self.type = t
            self.publicKeyData = d
        } else {
            return nil
        }
    }
    
    init?(publicKeyHex:String, type: SignatureOption) {
        if let data = publicKeyHex.hexadecimal() {
            self.publicKeyData = data
            self.type = type
        } else {
            return nil
        }
    }
    
    init?(hex:String) {
        if let data = hex.hexadecimal() {
            let result = HGCPublickKeyAddress.extractData(data: data)
            if let d = result.data, let t = result.type  {
                self.type = t
                self.publicKeyData = d
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    init?(from stringRepresentation:String?) {
        if let data = stringRepresentation?.hexadecimal()  {
            let result = HGCPublickKeyAddress.extractData(data: data)
            if let d = result.data, let t = result.type  {
                self.type = t
                self.publicKeyData = d
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    func stringRepresentation() -> String {
        return self.publicKeyData.hex
    }
    
    static func getType(publicKeyData : Data) -> SignatureOption? {
        let length = publicKeyData.count
        switch length {
        case HGCPublickKeyAddress.lengthEC:
            return .ECDSA
        case HGCPublickKeyAddress.lengthED:
            return .ED25519
        case HGCPublickKeyAddress.lengthRSA:
            return .RSA
        default:
            return nil
        }
    }
}

//asg asg asg asg

//
//  HGCAccount+CoreDataClass.swift
//  HGCApp
//




//asg
