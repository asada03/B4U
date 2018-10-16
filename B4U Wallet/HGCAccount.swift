//
//  HGCAccount.swift
//  B4U Wallet
//
//  Created by Andres Luis Sada Govela on 15/10/18.
//  Copyright © 2018 Andres Luis Sada Govela. All rights reserved.
//

import UIKit
import Foundation
import CoreData

struct HGCAccountID : Comparable {
    var shardId: Int64
    var realmId : Int64
    var accountId : Int64
    
    init(shardId: Int64, realmId: Int64, accountId: Int64) {
        self.shardId = shardId
        self.realmId = realmId
        self.accountId = accountId
    }
    
    init?(from stringRepresentation:String?) {
        var shard: Int64?
        var realm : Int64?
        var account : Int64?
        if let items = stringRepresentation?.split(separator: ".") {
            if items.count == 3 {
                shard = Int64(items[0])
                realm = Int64(items[1])
                account = Int64(items[2])
            }
        }
        
        if  shard != nil && realm != nil && account != nil {
            self.shardId = shard!
            self.realmId = realm!
            self.accountId = account!
            
        } else {
            return nil
        }
    }
    
    func stringRepresentation() -> String {
        let items = [shardId.description,realmId.description,accountId.description]
        return items.joined(separator: ".")
    }
    
    static func < (lhs: HGCAccountID, rhs: HGCAccountID) -> Bool {
        return lhs.accountId == rhs.accountId && lhs.realmId == rhs.realmId && lhs.shardId == rhs.shardId
    }
}

extension Proto_AccountID {
    func hgcAccountID() -> HGCAccountID {
        return HGCAccountID.init(shardId: self.shardNum, realmId: self.realmNum, accountId: self.accountNum)
    }
}

extension Proto_ContractID {
    func hgcAccountID() -> HGCAccountID {
        return HGCAccountID.init(shardId: self.shardNum, realmId: self.realmNum, accountId: self.contractNum)
    }
}

extension Notification.Name {
    static let onAccountUpdate = Notification.Name("onAccountUpdate")
}

class HGCAccount {
    
}

extension HGCAccount {
    public static let entityName = "Account"
    
    @available(iOS 10.0, *)
    private func key() -> HGCKeyPairProtocol {
        return self.wallet!.keyChain()!.key(at: Int(self.accountNumber))
    }
    
    func sign(_ data: Data) -> Data {
        let signature = self.key().signMessage(data)
        return signature!
        
    }
    
    func publicKeyData() -> Data {
        if self.publicKey == nil {
            self.publicKey = (self.key().publicKeyData)!
        }
        return self.publicKey! as Data
    }
    
    func publicKeyString() -> String {
        return "302a300506032b65700321008644263a9f0e35aa2603f326b19ae36c4100b1c1f8287d3884a08bd9d7e27430"
    }
    
    func privateKeyString() -> String {
        return "302e020100300506032b6570042204205b854e0e91c2d88453ed6248c8802ca96b893c10cc994e2eed8135e9cb3e3080"
    }
    
    @discardableResult
    func createTransaction(toAccountID:HGCAccountID?, txn:Proto_Transaction, _ coreDataManager : CoreDataManagerProtocol = CoreDataManager.shared) -> HGCRecord {
        let context = coreDataManager.mainContext
        let record = HGCRecord.getOrCreateTxn(txn:txn, context:context)
        record.fromAccountID = self.accountID()?.stringRepresentation()
        coreDataManager.saveContext()
        return record
    }
    
    func getAllTxn(context:NSManagedObjectContext = CoreDataManager.shared.mainContext) -> [TransactionVO] {
        if let accID = self.accountID() {
            if let result = HGCRecord.allTxn(accID.stringRepresentation(), context) {
                return result
            }
        }
        
        return [TransactionVO]()
    }
    
    // MARK:- Smart Contract Token
    @discardableResult
    func createToken(token:TokenVO, context:NSManagedObjectContext = CoreDataManager.shared.mainContext) -> SCToken {
        let object = NSEntityDescription.insertNewObject(forEntityName: SCToken.entityName, into: context) as! SCToken
        //object.address = token.address
        object.contractID = token.contractID.stringRepresentation()
        object.name = token.name
        object.symbol = token.symbol
        object.decimals = token.decimals
        object.account = self
        return object
    }
}

extension HGCAccount {
    func publicKeyAddress() -> HGCPublickKeyAddress {
        return HGCPublickKeyAddress.init(publicKeyData: self.publicKeyData(), type: self.wallet!.signatureOption())!
    }
    
    func accountID() -> HGCAccountID? {
        if shardId > 0 || realmId > 0 || accountId > 0 {
            return HGCAccountID.init(shardId: shardId, realmId: realmId, accountId: accountId)
        } else {
            return nil
        }
    }
    
    func updateAccountID(_ accId:HGCAccountID) {
        self.shardId = accId.shardId
        self.realmId = accId.realmId
        self.accountId = accId.accountId
    }
    
    func account() -> AccountVO {
        if let accID = accountID() {
            let acc = AccountVO.init(accountID: accID)
            return acc
            
        } else {
            let acc = AccountVO.init(address: publicKeyAddress())
            return acc
        }
    }
    
    func toJSONString(includePrivateKey:Bool) -> String {
        var map = [String:Any]()
        map["accountLabel"] = name
        map["accountIndex"] = accountNumber
        if let accID = accountID() {
            map["accountID"] = accID.stringRepresentation()
        }
        map["publicKey"] = publicKeyString()
        if includePrivateKey {
            map["privateKey"] = privateKeyString()
        }
        do {
            let data = try JSONSerialization.data(withJSONObject: map, options: JSONSerialization.WritingOptions.init(rawValue: 0))
            let string = String.init(data: data, encoding: .utf8)!
            return string
        } catch {
            Logger.instance.log(message: error.localizedDescription, event: .e)
            return ""
        }
    }
    
    func clearData()  {
        // clear balance and records
        balance = 0
        let isDefaultAcc = self.accountNumber == 0
        if let accId = self.accountID(), let contextObj = self.managedObjectContext {
            if let records = HGCRecord.allTxnRecords(isDefaultAcc ? nil : accId.stringRepresentation(), contextObj) {
                for record in records {
                    contextObj.delete(record)
                }
            }
        }
    }
}


