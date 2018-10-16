// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: CryptoGetAccountRecords.proto
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

/// Get all the records for an account for any transfers into it and out of it, that were above the threshold, during the last 24 hours. 
struct Proto_CryptoGetAccountRecordsQuery {
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

  /// the account for which the records should be retrieved
  var accountID: Proto_AccountID {
    get {return _storage._accountID ?? Proto_AccountID()}
    set {_uniqueStorage()._accountID = newValue}
  }
  /// Returns true if `accountID` has been explicitly set.
  var hasAccountID: Bool {return _storage._accountID != nil}
  /// Clears the value of `accountID`. Subsequent reads from it will return its default value.
  mutating func clearAccountID() {_uniqueStorage()._accountID = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

/// Response when the client sends the node CryptoGetAccountRecordsQuery 
struct Proto_CryptoGetAccountRecordsResponse {
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

  /// the account that this record is for
  var accountID: Proto_AccountID {
    get {return _storage._accountID ?? Proto_AccountID()}
    set {_uniqueStorage()._accountID = newValue}
  }
  /// Returns true if `accountID` has been explicitly set.
  var hasAccountID: Bool {return _storage._accountID != nil}
  /// Clears the value of `accountID`. Subsequent reads from it will return its default value.
  mutating func clearAccountID() {_uniqueStorage()._accountID = nil}

  /// list of records, each with CryptoRecordBody as their body
  var records: [Proto_TransactionRecord] {
    get {return _storage._records}
    set {_uniqueStorage()._records = newValue}
  }

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "proto"

extension Proto_CryptoGetAccountRecordsQuery: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".CryptoGetAccountRecordsQuery"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "header"),
    2: .same(proto: "accountID"),
  ]

  fileprivate class _StorageClass {
    var _header: Proto_QueryHeader? = nil
    var _accountID: Proto_AccountID? = nil

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _header = source._header
      _accountID = source._accountID
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
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Proto_CryptoGetAccountRecordsQuery, rhs: Proto_CryptoGetAccountRecordsQuery) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._header != rhs_storage._header {return false}
        if _storage._accountID != rhs_storage._accountID {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Proto_CryptoGetAccountRecordsResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".CryptoGetAccountRecordsResponse"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "header"),
    2: .same(proto: "accountID"),
    3: .same(proto: "records"),
  ]

  fileprivate class _StorageClass {
    var _header: Proto_ResponseHeader? = nil
    var _accountID: Proto_AccountID? = nil
    var _records: [Proto_TransactionRecord] = []

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _header = source._header
      _accountID = source._accountID
      _records = source._records
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
        case 3: try decoder.decodeRepeatedMessageField(value: &_storage._records)
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
      if !_storage._records.isEmpty {
        try visitor.visitRepeatedMessageField(value: _storage._records, fieldNumber: 3)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Proto_CryptoGetAccountRecordsResponse, rhs: Proto_CryptoGetAccountRecordsResponse) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._header != rhs_storage._header {return false}
        if _storage._accountID != rhs_storage._accountID {return false}
        if _storage._records != rhs_storage._records {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
