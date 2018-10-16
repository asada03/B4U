//
//  ApiRequestBuilder.swift
//  B4U Wallet
//
//  Created by Andres Luis Sada Govela on 15/10/18.
//  Copyright © 2018 Andres Luis Sada Govela. All rights reserved.
//

import Foundation

class APIRequestBuilder {
    fileprivate static let txnFee : UInt64 = 10
    
    static func requestForCreateNewAccount(fromAccount:HGCAccount, address:HGCPublickKeyAddress, initialBal:UInt64, notes:String?, node: HGCAccountID) -> Proto_Transaction {//asg
        let key = address.protoKey()
        var body = Proto_CryptoCreateTransactionBody.init()
        body.key = key
        body.initialBalance = initialBal
        body.receiverSigRequired = false
        body.sendRecordThreshold = 100
        body.receiveRecordThreshold = 100
        
        var txnBody = fromAccount.txnBody(memo: notes, node: node.protoAccountID(), generateRecord: true)
        txnBody.cryptoCreateAccount = body
        
        let txn = fromAccount.transaction(body: txnBody, shouldAddExtraSignature: true)
        return txn
    }
    
    static func requestForTransfer(fromAccount:HGCAccount, toAccount:HGCAccountID, amount:UInt64, notes:String?, node:HGCAccountID) -> Proto_Transaction {
        
        var payerAccount = Proto_AccountID.init()
        if let acc = fromAccount.accountID() {
            payerAccount = acc.protoAccountID()
        }
        
        var txnBody = fromAccount.txnBody(memo: notes, node: node.protoAccountID(), generateRecord: true)
        txnBody.cryptoTransfer = Proto_CryptoTransferTransactionBody.body(from: payerAccount, to: toAccount.protoAccountID(), amount: amount)
        
        let txn = fromAccount.transaction(body: txnBody, shouldAddExtraSignature: true)
        return txn
    }
    
    static func requestForGetTxnReceipt(fromAccount:HGCAccount, paramTxnId:Proto_TransactionID, node:HGCAccountID) -> Proto_Query {
        let qHeader = fromAccount.createQueryHeader(node: node, memo: "for receipt", includePayment: false)
        var txnGetReceiptQuery = Proto_TransactionGetReceiptQuery.init()
        txnGetReceiptQuery.header = qHeader
        txnGetReceiptQuery.transactionID = paramTxnId
        var query = Proto_Query.init()
        query.transactionGetReceipt = txnGetReceiptQuery
        return query
    }
    
    static func requestForGetTxnRecord(fromAccount:HGCAccount, paramTxnId:Proto_TransactionID, node:HGCAccountID) -> Proto_Query {
        let qHeader = fromAccount.createQueryHeader(node: node, memo: "for txn record")
        var txnGetRecordQuery = Proto_TransactionGetRecordQuery.init()
        txnGetRecordQuery.header = qHeader
        txnGetRecordQuery.transactionID = paramTxnId
        var query = Proto_Query.init()
        query.transactionGetRecord = txnGetRecordQuery
        return query
    }
    
    static func getBalanceQuery(fromAccount:HGCAccount, accountID:HGCAccountID, node:HGCAccountID) -> Proto_Query {
        let qHeader = fromAccount.createQueryHeader(node: node, memo: "for balance check")
        var getBalaceQuery = Proto_CryptoGetAccountBalanceQuery.init()
        getBalaceQuery.header = qHeader
        getBalaceQuery.accountID = accountID.protoAccountID()
        var query = Proto_Query.init()
        query.cryptogetAccountBalance = getBalaceQuery
        return query
    }
    
    static func getAccountRecordQuery(fromAccount:HGCAccount, accountID:HGCAccountID, node:HGCAccountID) -> Proto_Query {
        let qHeader = fromAccount.createQueryHeader(node: node, memo: "for account record")
        var accRecordQuery = Proto_CryptoGetAccountRecordsQuery.init()
        accRecordQuery.header = qHeader
        accRecordQuery.accountID = accountID.protoAccountID()
        var query = Proto_Query.init()
        query.cryptoGetAccountRecords = accRecordQuery
        return query
    }
    
    static func requestForReadingSymbol(fromAccount:HGCAccount, contractID:HGCAccountID, node:HGCAccountID) -> Proto_Query {
        return APIRequestBuilder.smartContractCall(fromAccount: fromAccount, contractID: contractID, funName: "symbol", node: node)
    }
    
    static func requestForReadingDecimals(fromAccount:HGCAccount, contractID:HGCAccountID, node:HGCAccountID) -> Proto_Query {
        return APIRequestBuilder.smartContractCall(fromAccount: fromAccount, contractID: contractID, funName: "decimals", node: node)
    }
    
    static func requestForReadingName(fromAccount:HGCAccount, contractID:HGCAccountID, node:HGCAccountID) -> Proto_Query {
        return APIRequestBuilder.smartContractCall(fromAccount: fromAccount, contractID: contractID, funName: "name", node: node)
    }
    
    private static func smartContractCall(fromAccount:HGCAccount, contractID:HGCAccountID, funName:String, node:HGCAccountID) -> Proto_Query {
        let function = EthFunction(name: funName, inputParameters: [])
        let encodedFunction = web3swift.encode(function)
        
        var contractCallQuery = Proto_ContractCallLocalQuery.init()
        contractCallQuery.header = fromAccount.createQueryHeader(node: node, memo: "for smart contract function call")
        contractCallQuery.contractID = contractID.protoContractID()
        contractCallQuery.functionParameters = encodedFunction
        contractCallQuery.gas = 100000
        contractCallQuery.maxResultSize = 10000000000
        var query = Proto_Query.init()
        query.contractCallLocal = contractCallQuery
        return query
    }
    
    static func smartContractGetBalanceCall(fromAccount:HGCAccount, ethAccountAddress:String, contractID:HGCAccountID, node:HGCAccountID) -> Proto_Query {
        let ethToAccountAddress: GethAddress! = GethNewAddressFromHex(ethAccountAddress,nil)!
        let function = EthFunction(name: "balanceOf", inputParameters:[ethToAccountAddress])
        let encodedFunction = web3swift.encode(function)
        
        var contractCallQuery = Proto_ContractCallLocalQuery.init()
        contractCallQuery.header = fromAccount.createQueryHeader(node: node, memo: "for smart contract function call")
        contractCallQuery.contractID = contractID.protoContractID()
        contractCallQuery.functionParameters = encodedFunction
        contractCallQuery.gas = 100000
        contractCallQuery.maxResultSize = 10000000000
        var query = Proto_Query.init()
        query.contractCallLocal = contractCallQuery
        return query
    }
    
    
    static func requestForTransferOnContract(fromAccount:HGCAccount, ethToAddress:String, amount:Int64, contract:TokenVO, gas:UInt64, notes:String?, node:HGCAccountID) -> Proto_Transaction {
        let ethToAccountAddress: GethAddress! = GethNewAddressFromHex(ethToAddress,nil)!
        let ethAmount = GethBigInt.bigInt((Int64(contract.multiplier()) * amount).description)!
        let transferFunction = EthFunction(name: "transfer", inputParameters: [ethToAccountAddress, ethAmount])
        let encodedTransferFunction = web3swift.encode(transferFunction)
        
        var call = Proto_ContractCallTransactionBody.init()
        call.contractID = contract.contractID.protoContractID()
        call.gas = Int64(gas)
        call.functionParameters = encodedTransferFunction
        call.amount = 0
        var txnBody = fromAccount.txnBody(memo: notes, node: node.protoAccountID(), generateRecord: true)
        txnBody.contractCall = call
        
        let txn = fromAccount.transaction(body: txnBody, shouldAddExtraSignature: true)
        return txn
        
    }
    
    static func requestForGetAccountInfo(fromAccount:HGCAccount, accountID:HGCAccountID, node:HGCAccountID) -> Proto_Query {
        var getInfoQuery = Proto_CryptoGetInfoQuery.init()
        getInfoQuery.header = fromAccount.createQueryHeader(node: node, memo: "for get account info")
        getInfoQuery.accountID = accountID.protoAccountID()
        var query = Proto_Query.init()
        query.cryptoGetInfo = getInfoQuery
        return query
    }
    
}

extension HGCAccountID { //asg
    func protoAccountID() -> Proto_AccountID {
        var acc = Proto_AccountID.init()
        acc.accountNum = accountId
        acc.realmNum = realmId
        acc.shardNum = shardId
        return acc
    }
    
    func protoContractID() -> Proto_ContractID {
        var acc = Proto_ContractID.init()
        acc.contractNum = accountId
        acc.realmNum = realmId
        acc.shardNum = shardId
        return acc
    }
}

extension Proto_CryptoTransferTransactionBody {
    static func body(from: Proto_AccountID, to: Proto_AccountID, amount:UInt64) -> Proto_CryptoTransferTransactionBody {
        var accAmount1 = Proto_AccountAmount.init()
        accAmount1.accountID = from
        accAmount1.amount = -1 * Int64(amount)
        
        var accAmount2 = Proto_AccountAmount.init()
        accAmount2.accountID = to
        accAmount2.amount = Int64(amount)
        
        var list = Proto_TransferList.init()
        list.accountAmounts = [accAmount1, accAmount2]
        
        var body = Proto_CryptoTransferTransactionBody.init()
        body.transfers = list
        return body
    }
}

extension TimeInterval {
    func protoDuration() -> Proto_Duration {
        var d = Proto_Duration.init()
        let o = self.extractSecondsAndNanos()
        d.seconds = o.seconds
        d.nanos = o.nanos
        return d
    }
    
    func protoTimestamp() -> Proto_Timestamp {
        var d = Proto_Timestamp.init()
        let o = self.extractSecondsAndNanos()
        d.seconds = o.seconds
        d.nanos = o.nanos
        return d
    }
    
    func extractSecondsAndNanos() -> (seconds:Int64, nanos:Int32) {
        let seconds = Int64(floor(self))
        let nanos = Int32((self - TimeInterval(seconds)) * 1000000000)
        return (seconds, nanos)
    }
}

extension HGCAccount { //asg
    func txnBody(memo:String?, node:Proto_AccountID, generateRecord:Bool = false) -> Proto_TransactionBody {
        var txnId = Proto_TransactionID.init()
        var payerAccount = Proto_AccountID.init()
        if let acc = self.accountID() {
            payerAccount = acc.protoAccountID()
        }
        txnId.transactionValidStart = Date().timeIntervalSince1970.protoTimestamp()
        txnId.accountID = payerAccount
        
        var txnBody = Proto_TransactionBody.init()
        txnBody.transactionID = txnId
        txnBody.transactionFee = APIRequestBuilder.txnFee
        txnBody.transactionValidDuration = TimeInterval(30).protoDuration()
        txnBody.generateRecord = generateRecord
        txnBody.memo = memo ?? ""
        txnBody.nodeAccountID = node
        return txnBody
    }
    
    func transaction(body:Proto_TransactionBody, shouldAddExtraSignature:Bool) -> Proto_Transaction {
        var list = Proto_SignatureList.init()
        if shouldAddExtraSignature {
            list.sigs = [getSignature(body: body), getSignature(body: body)]
        } else {
            list.sigs = [getSignature(body: body)]
        }
        
        var txn = Proto_Transaction.init()
        txn.body = body
        txn.sigs = list
        return txn
    }
    
    func getSignature(body:Proto_TransactionBody) -> Proto_Signature {
        var signature = Proto_Signature.init()
        if let sig = try? sign(body.serializedData()) {
            switch self.wallet!.signatureOption() {
            case .ECDSA:
                signature.ecdsa384 = sig
            case .ED25519:
                signature.ed25519 = sig
            case .RSA:
                signature.rsa3072 = sig
            }
        }
        return signature
    }
    
    func createQueryHeader(node:HGCAccountID, memo:String, includePayment:Bool = true) -> Proto_QueryHeader {
        var payerAccount = Proto_AccountID.init()
        if let acc = accountID() {
            payerAccount = acc.protoAccountID()
        }
        
        let nodeAccount = node.protoAccountID()
        var body = txnBody(memo: memo, node: nodeAccount)
        body.cryptoTransfer = Proto_CryptoTransferTransactionBody.body(from: payerAccount, to: nodeAccount, amount: APIRequestBuilder.txnFee)
        let txn = transaction(body: body, shouldAddExtraSignature: true)
        
        var qHeader = Proto_QueryHeader.init()
        if includePayment {
            qHeader.payment = txn
        }
        qHeader.responseType = .answerOnly
        return qHeader
    }
}

extension HGCPublickKeyAddress {
    func protoKey() -> Proto_Key {
        var key = Proto_Key.init()
        switch self.type {
        case .ECDSA:
            key.ecdsa384 = self.publicKeyData
        case .ED25519:
            key.ed25519 = self.publicKeyData
        case .RSA:
            key.rsa3072 = self.publicKeyData
        }
        return key
    }
}
