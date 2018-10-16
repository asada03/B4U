// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: CryptoCreate.proto
//
// For information on using the generated types, please see the documenation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that your are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

/// Create a new account. After the account is created, the AccountID for it is in the receipt, or can be retrieved with a GetByKey query, or by asking for a Record of the transaction to be created, and retrieving that. The account can then automatically generate records for large transfers into it or out of it, which each last for 24 hours. Records are generated for any transfer that exceeds the thresholds given here. This account is charged cryptocurrency for each record generated, so the thresholds are useful for limiting Record generation to happen only for large transactions. The Key field is the key used to sign transactions for this account. If the account has receiverSigRequired set to true, then all cryptocurrency transfers must be signed by this account's key, both for transfers in and out. If it is false, then only transfers out have to be signed by it. When the account is created, the payer account is charged enough hbars so that the new account will not expire for the next autoRenewPeriod seconds. When it reaches the expiration time, the new account will then be automatically charged to renew for another autoRenewPeriod seconds. If it does not have enough hbars to renew for that long, then the remaining hbars are used to extend its expiration as long as possible. If it is has a zero balance when it expires, then it is deleted. This transaction must be signed by the payer account. If receiverSigRequired is false, then the transaction does not have to be signed by the keys in the keys field. If it is true, then it must be signed by them, in addition to the keys of the payer account.
///
/// An entity (account, file, or smart contract instance) must be created in a particular realm. If the realmID is left null, then a new realm will be created with the given admin key. If a new realm has a null adminKey, then anyone can create/modify/delete entities in that realm. But if an admin key is given, then any transaction to create/modify/delete an entity in that realm must be signed by that key, though anyone can still call functions on smart contract instances that exist in that realm. A realm ceases to exist when everything within it has expired and no longer exists.
///
/// The current API ignores shardID, realmID, and newRealmAdminKey, and creates everything in shard 0 and realm 0, with a null key. Future versions of the API will support multiple realms and multiple shards.
struct Proto_CryptoCreateTransactionBody {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// the key that must sign each transfer out of the account. If receiverSigRequired is true, then it must also sign any transfer into the account.
  var key: Proto_Key {
    get {return _storage._key ?? Proto_Key()}
    set {_uniqueStorage()._key = newValue}
  }
  /// Returns true if `key` has been explicitly set.
  var hasKey: Bool {return _storage._key != nil}
  /// Clears the value of `key`. Subsequent reads from it will return its default value.
  mutating func clearKey() {_uniqueStorage()._key = nil}

  /// the initial number of tinybars to put into the account
  var initialBalance: UInt64 {
    get {return _storage._initialBalance}
    set {_uniqueStorage()._initialBalance = newValue}
  }

  /// ID of the account to which this account is proxy staked. If proxyAccountID is null, or is an invalid account, or is an account that isn't a node, then this account is automatically proxy staked to a node chosen by the network, but without earning payments. If the proxyAccountID account refuses to accept proxy staking at the given fraction, or if it is not currently running a node, then it will behave as if both proxyAccountID and proxyFraction were null.
  var proxyAccountID: Proto_AccountID {
    get {return _storage._proxyAccountID ?? Proto_AccountID()}
    set {_uniqueStorage()._proxyAccountID = newValue}
  }
  /// Returns true if `proxyAccountID` has been explicitly set.
  var hasProxyAccountID: Bool {return _storage._proxyAccountID != nil}
  /// Clears the value of `proxyAccountID`. Subsequent reads from it will return its default value.
  mutating func clearProxyAccountID() {_uniqueStorage()._proxyAccountID = nil}

  /// payments earned from proxy staking are shared between the node and this account, with proxyFraction / 10000 going to this account
  var proxyFraction: Int32 {
    get {return _storage._proxyFraction}
    set {_uniqueStorage()._proxyFraction = newValue}
  }

  /// when another account tries to proxy stake to this account, accept it only if the proxyFraction from that other account is at most maxReceiveProxyFraction
  var maxReceiveProxyFraction: Int32 {
    get {return _storage._maxReceiveProxyFraction}
    set {_uniqueStorage()._maxReceiveProxyFraction = newValue}
  }

  /// create an account record for any transaction withdrawing more than this many tinybars
  var sendRecordThreshold: UInt64 {
    get {return _storage._sendRecordThreshold}
    set {_uniqueStorage()._sendRecordThreshold = newValue}
  }

  /// create an account record for any transaction depositing more than this many tinybars
  var receiveRecordThreshold: UInt64 {
    get {return _storage._receiveRecordThreshold}
    set {_uniqueStorage()._receiveRecordThreshold = newValue}
  }

  /// if true, this account's key must sign any transaction depositing into this account (in addition to all withdrawals). This field is immutable; it cannot be changed by a CryptoUpdate transaction.
  var receiverSigRequired: Bool {
    get {return _storage._receiverSigRequired}
    set {_uniqueStorage()._receiverSigRequired = newValue}
  }

  /// the account is charged to extend its expiration date every this many seconds. If it doesn't have enough, it extends as long as possible. If it is empty when it expires, then it is deleted.
  var autoRenewPeriod: Proto_Duration {
    get {return _storage._autoRenewPeriod ?? Proto_Duration()}
    set {_uniqueStorage()._autoRenewPeriod = newValue}
  }
  /// Returns true if `autoRenewPeriod` has been explicitly set.
  var hasAutoRenewPeriod: Bool {return _storage._autoRenewPeriod != nil}
  /// Clears the value of `autoRenewPeriod`. Subsequent reads from it will return its default value.
  mutating func clearAutoRenewPeriod() {_uniqueStorage()._autoRenewPeriod = nil}

  /// shard in which to create this
  var shardID: Proto_ShardID {
    get {return _storage._shardID ?? Proto_ShardID()}
    set {_uniqueStorage()._shardID = newValue}
  }
  /// Returns true if `shardID` has been explicitly set.
  var hasShardID: Bool {return _storage._shardID != nil}
  /// Clears the value of `shardID`. Subsequent reads from it will return its default value.
  mutating func clearShardID() {_uniqueStorage()._shardID = nil}

  /// realm in which to create this (leave this null to create a new realm)
  var realmID: Proto_RealmID {
    get {return _storage._realmID ?? Proto_RealmID()}
    set {_uniqueStorage()._realmID = newValue}
  }
  /// Returns true if `realmID` has been explicitly set.
  var hasRealmID: Bool {return _storage._realmID != nil}
  /// Clears the value of `realmID`. Subsequent reads from it will return its default value.
  mutating func clearRealmID() {_uniqueStorage()._realmID = nil}

  /// if realmID is null, then this the admin key for the new realm that will be created
  var newRealmAdminKey: Proto_Key {
    get {return _storage._newRealmAdminKey ?? Proto_Key()}
    set {_uniqueStorage()._newRealmAdminKey = newValue}
  }
  /// Returns true if `newRealmAdminKey` has been explicitly set.
  var hasNewRealmAdminKey: Bool {return _storage._newRealmAdminKey != nil}
  /// Clears the value of `newRealmAdminKey`. Subsequent reads from it will return its default value.
  mutating func clearNewRealmAdminKey() {_uniqueStorage()._newRealmAdminKey = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "proto"

extension Proto_CryptoCreateTransactionBody: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    func _protobuf_generated_isEqualTo(other: Proto_CryptoCreateTransactionBody) -> Bool {
        return false
    }
    
  static let protoMessageName: String = _protobuf_package + ".CryptoCreateTransactionBody"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "key"),
    2: .same(proto: "initialBalance"),
    3: .same(proto: "proxyAccountID"),
    4: .same(proto: "proxyFraction"),
    5: .same(proto: "maxReceiveProxyFraction"),
    6: .same(proto: "sendRecordThreshold"),
    7: .same(proto: "receiveRecordThreshold"),
    8: .same(proto: "receiverSigRequired"),
    9: .same(proto: "autoRenewPeriod"),
    10: .same(proto: "shardID"),
    11: .same(proto: "realmID"),
    12: .same(proto: "newRealmAdminKey"),
  ]

  fileprivate class _StorageClass {
    var _key: Proto_Key? = nil
    var _initialBalance: UInt64 = 0
    var _proxyAccountID: Proto_AccountID? = nil
    var _proxyFraction: Int32 = 0
    var _maxReceiveProxyFraction: Int32 = 0
    var _sendRecordThreshold: UInt64 = 0
    var _receiveRecordThreshold: UInt64 = 0
    var _receiverSigRequired: Bool = false
    var _autoRenewPeriod: Proto_Duration? = nil
    var _shardID: Proto_ShardID? = nil
    var _realmID: Proto_RealmID? = nil
    var _newRealmAdminKey: Proto_Key? = nil

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _key = source._key
      _initialBalance = source._initialBalance
      _proxyAccountID = source._proxyAccountID
      _proxyFraction = source._proxyFraction
      _maxReceiveProxyFraction = source._maxReceiveProxyFraction
      _sendRecordThreshold = source._sendRecordThreshold
      _receiveRecordThreshold = source._receiveRecordThreshold
      _receiverSigRequired = source._receiverSigRequired
      _autoRenewPeriod = source._autoRenewPeriod
      _shardID = source._shardID
      _realmID = source._realmID
      _newRealmAdminKey = source._newRealmAdminKey
    }
  }

  fileprivate mutating func _uniqueStorage() -> _StorageClass {
    if !isKnownUniquelyReferenced(&_storage) {
      _storage = _StorageClass(copying: _storage)
    }
    return _storage
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    _ = _uniqueStorage()
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      while let fieldNumber = try decoder.nextFieldNumber() {
        switch fieldNumber {
        case 1: try decoder.decodeSingularMessageField(value: &_storage._key)
        case 2: try decoder.decodeSingularUInt64Field(value: &_storage._initialBalance)
        case 3: try decoder.decodeSingularMessageField(value: &_storage._proxyAccountID)
        case 4: try decoder.decodeSingularInt32Field(value: &_storage._proxyFraction)
        case 5: try decoder.decodeSingularInt32Field(value: &_storage._maxReceiveProxyFraction)
        case 6: try decoder.decodeSingularUInt64Field(value: &_storage._sendRecordThreshold)
        case 7: try decoder.decodeSingularUInt64Field(value: &_storage._receiveRecordThreshold)
        case 8: try decoder.decodeSingularBoolField(value: &_storage._receiverSigRequired)
        case 9: try decoder.decodeSingularMessageField(value: &_storage._autoRenewPeriod)
        case 10: try decoder.decodeSingularMessageField(value: &_storage._shardID)
        case 11: try decoder.decodeSingularMessageField(value: &_storage._realmID)
        case 12: try decoder.decodeSingularMessageField(value: &_storage._newRealmAdminKey)
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if let v = _storage._key {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
      }
      if _storage._initialBalance != 0 {
        try visitor.visitSingularUInt64Field(value: _storage._initialBalance, fieldNumber: 2)
      }
      if let v = _storage._proxyAccountID {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 3)
      }
      if _storage._proxyFraction != 0 {
        try visitor.visitSingularInt32Field(value: _storage._proxyFraction, fieldNumber: 4)
      }
      if _storage._maxReceiveProxyFraction != 0 {
        try visitor.visitSingularInt32Field(value: _storage._maxReceiveProxyFraction, fieldNumber: 5)
      }
      if _storage._sendRecordThreshold != 0 {
        try visitor.visitSingularUInt64Field(value: _storage._sendRecordThreshold, fieldNumber: 6)
      }
      if _storage._receiveRecordThreshold != 0 {
        try visitor.visitSingularUInt64Field(value: _storage._receiveRecordThreshold, fieldNumber: 7)
      }
      if _storage._receiverSigRequired != false {
        try visitor.visitSingularBoolField(value: _storage._receiverSigRequired, fieldNumber: 8)
      }
      if let v = _storage._autoRenewPeriod {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 9)
      }
      if let v = _storage._shardID {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 10)
      }
      if let v = _storage._realmID {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 11)
      }
      if let v = _storage._newRealmAdminKey {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 12)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Proto_CryptoCreateTransactionBody, rhs: Proto_CryptoCreateTransactionBody) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._key != rhs_storage._key {return false}
        if _storage._initialBalance != rhs_storage._initialBalance {return false}
        if _storage._proxyAccountID != rhs_storage._proxyAccountID {return false}
        if _storage._proxyFraction != rhs_storage._proxyFraction {return false}
        if _storage._maxReceiveProxyFraction != rhs_storage._maxReceiveProxyFraction {return false}
        if _storage._sendRecordThreshold != rhs_storage._sendRecordThreshold {return false}
        if _storage._receiveRecordThreshold != rhs_storage._receiveRecordThreshold {return false}
        if _storage._receiverSigRequired != rhs_storage._receiverSigRequired {return false}
        if _storage._autoRenewPeriod != rhs_storage._autoRenewPeriod {return false}
        if _storage._shardID != rhs_storage._shardID {return false}
        if _storage._realmID != rhs_storage._realmID {return false}
        if _storage._newRealmAdminKey != rhs_storage._newRealmAdminKey {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}