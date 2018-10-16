// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: CryptoGetClaim.proto
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

/// Get a single claim attached to an account, or return null if it does not exist. 
struct Proto_CryptoGetClaimQuery {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// standard info sent from client to node, including the signed payment, and what kind of response is requested (cost, state proof, both, or neither).
  var header: Proto_QueryHeader {
    get {return _storage._header ?? Proto_QueryHeader()}
    set {_uniqueStorage()._header = newValue}
  }
  /// Returns true if `header` has been explicitly set.
  var hasHeader: Bool {return _storage._header != nil}
  /// Clears the value of `header`. Subsequent reads from it will return its default value.
  mutating func clearHeader() {_uniqueStorage()._header = nil}

  /// the account to which the claim may be attached
  var accountID: Proto_AccountID {
    get {return _storage._accountID ?? Proto_AccountID()}
    set {_uniqueStorage()._accountID = newValue}
  }
  /// Returns true if `accountID` has been explicitly set.
  var hasAccountID: Bool {return _storage._accountID != nil}
  /// Clears the value of `accountID`. Subsequent reads from it will return its default value.
  mutating func clearAccountID() {_uniqueStorage()._accountID = nil}

  /// the hash of the claim
  var hash: Data {
    get {return _storage._hash}
    set {_uniqueStorage()._hash = newValue}
  }

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

/// Response when the client sends the node CryptoGetClaimQuery. If the claim exists, there can be a state proof for that single claim. If the claim doesn't exist, then the state proof must be obtained for the account as a whole, which lists all the attached claims, which then proves that any claim not on the list must not exist. 
struct Proto_CryptoGetClaimResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  ///standard response from node to client, including the requested fields: cost, or state proof, or both, or neither
  var header: Proto_ResponseHeader {
    get {return _storage._header ?? Proto_ResponseHeader()}
    set {_uniqueStorage()._header = newValue}
  }
  /// Returns true if `header` has been explicitly set.
  var hasHeader: Bool {return _storage._header != nil}
  /// Clears the value of `header`. Subsequent reads from it will return its default value.
  mutating func clearHeader() {_uniqueStorage()._header = nil}

  /// the claim (account, hash, keys), or null if there is no Claim with the given hash attached to the given account
  var claim: Proto_Claim {
    get {return _storage._claim ?? Proto_Claim()}
    set {_uniqueStorage()._claim = newValue}
  }
  /// Returns true if `claim` has been explicitly set.
  var hasClaim: Bool {return _storage._claim != nil}
  /// Clears the value of `claim`. Subsequent reads from it will return its default value.
  mutating func clearClaim() {_uniqueStorage()._claim = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "proto"

extension Proto_CryptoGetClaimQuery: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".CryptoGetClaimQuery"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "header"),
    2: .same(proto: "accountID"),
    3: .same(proto: "hash"),
  ]

  fileprivate class _StorageClass {
    var _header: Proto_QueryHeader? = nil
    var _accountID: Proto_AccountID? = nil
    var _hash: Data = SwiftProtobuf.Internal.emptyData

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _header = source._header
      _accountID = source._accountID
      _hash = source._hash
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
        case 1: try decoder.decodeSingularMessageField(value: &_storage._header)
        case 2: try decoder.decodeSingularMessageField(value: &_storage._accountID)
        case 3: try decoder.decodeSingularBytesField(value: &_storage._hash)
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if let v = _storage._header {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
      }
      if let v = _storage._accountID {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
      }
      if !_storage._hash.isEmpty {
        try visitor.visitSingularBytesField(value: _storage._hash, fieldNumber: 3)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Proto_CryptoGetClaimQuery, rhs: Proto_CryptoGetClaimQuery) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._header != rhs_storage._header {return false}
        if _storage._accountID != rhs_storage._accountID {return false}
        if _storage._hash != rhs_storage._hash {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Proto_CryptoGetClaimResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".CryptoGetClaimResponse"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "header"),
    2: .same(proto: "claim"),
  ]

  fileprivate class _StorageClass {
    var _header: Proto_ResponseHeader? = nil
    var _claim: Proto_Claim? = nil

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _header = source._header
      _claim = source._claim
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
        case 1: try decoder.decodeSingularMessageField(value: &_storage._header)
        case 2: try decoder.decodeSingularMessageField(value: &_storage._claim)
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if let v = _storage._header {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
      }
      if let v = _storage._claim {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Proto_CryptoGetClaimResponse, rhs: Proto_CryptoGetClaimResponse) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._header != rhs_storage._header {return false}
        if _storage._claim != rhs_storage._claim {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
