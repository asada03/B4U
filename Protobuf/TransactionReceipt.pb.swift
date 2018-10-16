// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: TransactionReceipt.proto
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

/// The consensus result for a transaction, which might not be currently known, or may  succeed or fail. 
enum Proto_TransactionStatus: SwiftProtobuf.Enum {
  typealias RawValue = Int

  /// hasn't yet reached consensus, or has already expired
  case unknown // = 0

  /// the transaction succeeded
  case success // = 1

  /// the transaction failed because it is invalid
  case failInvalid // = 2

  /// the transaction fee was insufficient
  case failFee // = 3

  /// the paying account had insufficient cryptocurrency
  case failBalance // = 4
  case UNRECOGNIZED(Int)

  init() {
    self = .unknown
  }

  init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .unknown
    case 1: self = .success
    case 2: self = .failInvalid
    case 3: self = .failFee
    case 4: self = .failBalance
    default: self = .UNRECOGNIZED(rawValue)
    }
  }

  var rawValue: Int {
    switch self {
    case .unknown: return 0
    case .success: return 1
    case .failInvalid: return 2
    case .failFee: return 3
    case .failBalance: return 4
    case .UNRECOGNIZED(let i): return i
    }
  }

}

#if swift(>=4.2)

extension Proto_TransactionStatus: CaseIterable {
  // The compiler won't synthesize support with the UNRECOGNIZED case.
  static var allCases: [Proto_TransactionStatus] = [
    .unknown,
    .success,
    .failInvalid,
    .failFee,
    .failBalance,
  ]
}

#endif  // swift(>=4.2)

/// The consensus result for a transaction, which might not be currently known, or may  succeed or fail. 
struct Proto_TransactionReceipt {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// whether the transaction succeeded or failed (or is unknown)
  var status: Proto_TransactionStatus {
    get {return _storage._status}
    set {_uniqueStorage()._status = newValue}
  }

  ///  the account ID, if a new account was created
  var accountID: Proto_AccountID {
    get {return _storage._accountID ?? Proto_AccountID()}
    set {_uniqueStorage()._accountID = newValue}
  }
  /// Returns true if `accountID` has been explicitly set.
  var hasAccountID: Bool {return _storage._accountID != nil}
  /// Clears the value of `accountID`. Subsequent reads from it will return its default value.
  mutating func clearAccountID() {_uniqueStorage()._accountID = nil}

  /// the file ID, if a new file was created
  var fileID: Proto_FileID {
    get {return _storage._fileID ?? Proto_FileID()}
    set {_uniqueStorage()._fileID = newValue}
  }
  /// Returns true if `fileID` has been explicitly set.
  var hasFileID: Bool {return _storage._fileID != nil}
  /// Clears the value of `fileID`. Subsequent reads from it will return its default value.
  mutating func clearFileID() {_uniqueStorage()._fileID = nil}

  /// the contract ID, if a new smart contract instance was created
  var contractID: Proto_ContractID {
    get {return _storage._contractID ?? Proto_ContractID()}
    set {_uniqueStorage()._contractID = newValue}
  }
  /// Returns true if `contractID` has been explicitly set.
  var hasContractID: Bool {return _storage._contractID != nil}
  /// Clears the value of `contractID`. Subsequent reads from it will return its default value.
  mutating func clearContractID() {_uniqueStorage()._contractID = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "proto"

extension Proto_TransactionStatus: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "UNKNOWN"),
    1: .same(proto: "SUCCESS"),
    2: .same(proto: "FAIL_INVALID"),
    3: .same(proto: "FAIL_FEE"),
    4: .same(proto: "FAIL_BALANCE"),
  ]
}

extension Proto_TransactionReceipt: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".TransactionReceipt"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "status"),
    2: .same(proto: "accountID"),
    3: .same(proto: "fileID"),
    4: .same(proto: "contractID"),
  ]

  fileprivate class _StorageClass {
    var _status: Proto_TransactionStatus = .unknown
    var _accountID: Proto_AccountID? = nil
    var _fileID: Proto_FileID? = nil
    var _contractID: Proto_ContractID? = nil

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _status = source._status
      _accountID = source._accountID
      _fileID = source._fileID
      _contractID = source._contractID
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
        case 1: try decoder.decodeSingularEnumField(value: &_storage._status)
        case 2: try decoder.decodeSingularMessageField(value: &_storage._accountID)
        case 3: try decoder.decodeSingularMessageField(value: &_storage._fileID)
        case 4: try decoder.decodeSingularMessageField(value: &_storage._contractID)
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if _storage._status != .unknown {
        try visitor.visitSingularEnumField(value: _storage._status, fieldNumber: 1)
      }
      if let v = _storage._accountID {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
      }
      if let v = _storage._fileID {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 3)
      }
      if let v = _storage._contractID {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 4)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Proto_TransactionReceipt, rhs: Proto_TransactionReceipt) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._status != rhs_storage._status {return false}
        if _storage._accountID != rhs_storage._accountID {return false}
        if _storage._fileID != rhs_storage._fileID {return false}
        if _storage._contractID != rhs_storage._contractID {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
