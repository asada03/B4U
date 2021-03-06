// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: AdminDelete.proto
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

/// Delete a file or smart contract - can only be done with a Hedera admin multisig. When it is deleted, it immediately disappears from the system as seen by the user, but is still stored internally until the expiration time, at which time it is truly and permanently deleted. Until that time, it can be undeleted by the Hedera admin multisig. When a smart contract is deleted, the cryptocurrency account within it continues to exist, and is not affected by the expiration time here. 
struct Proto_AdminDeleteTransactionBody {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var id: OneOf_ID? {
    get {return _storage._id}
    set {_uniqueStorage()._id = newValue}
  }

  /// the file to delete, in the format used in transactions
  var fileID: Proto_FileID {
    get {
      if case .fileID(let v)? = _storage._id {return v}
      return Proto_FileID()
    }
    set {_uniqueStorage()._id = .fileID(newValue)}
  }

  /// the contract instance to delete, in the format used in transactions
  var contractID: Proto_ContractID {
    get {
      if case .contractID(let v)? = _storage._id {return v}
      return Proto_ContractID()
    }
    set {_uniqueStorage()._id = .contractID(newValue)}
  }

  /// the time at which the "deleted" file should truly be permanently deleted
  var expirationTime: Proto_TimestampSeconds {
    get {return _storage._expirationTime ?? Proto_TimestampSeconds()}
    set {_uniqueStorage()._expirationTime = newValue}
  }
  /// Returns true if `expirationTime` has been explicitly set.
  var hasExpirationTime: Bool {return _storage._expirationTime != nil}
  /// Clears the value of `expirationTime`. Subsequent reads from it will return its default value.
  mutating func clearExpirationTime() {_uniqueStorage()._expirationTime = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  enum OneOf_ID: Equatable {
    /// the file to delete, in the format used in transactions
    case fileID(Proto_FileID)
    /// the contract instance to delete, in the format used in transactions
    case contractID(Proto_ContractID)

  #if !swift(>=4.1)
    static func ==(lhs: Proto_AdminDeleteTransactionBody.OneOf_ID, rhs: Proto_AdminDeleteTransactionBody.OneOf_ID) -> Bool {
      switch (lhs, rhs) {
      case (.fileID(let l), .fileID(let r)): return l == r
      case (.contractID(let l), .contractID(let r)): return l == r
      default: return false
      }
    }
  #endif
  }

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "proto"

extension Proto_AdminDeleteTransactionBody: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    func _protobuf_generated_isEqualTo(other: Proto_AdminDeleteTransactionBody) -> Bool {
        return false
    }
    
  static let protoMessageName: String = _protobuf_package + ".AdminDeleteTransactionBody"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "fileID"),
    2: .same(proto: "contractID"),
    3: .same(proto: "expirationTime"),
  ]

  fileprivate class _StorageClass {
    var _id: Proto_AdminDeleteTransactionBody.OneOf_ID?
    var _expirationTime: Proto_TimestampSeconds? = nil

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _id = source._id
      _expirationTime = source._expirationTime
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
        case 1:
          var v: Proto_FileID?
          if let current = _storage._id {
            try decoder.handleConflictingOneOf()
            if case .fileID(let m) = current {v = m}
          }
          try decoder.decodeSingularMessageField(value: &v)
          if let v = v {_storage._id = .fileID(v)}
        case 2:
          var v: Proto_ContractID?
          if let current = _storage._id {
            try decoder.handleConflictingOneOf()
            if case .contractID(let m) = current {v = m}
          }
          try decoder.decodeSingularMessageField(value: &v)
          if let v = v {_storage._id = .contractID(v)}
        case 3: try decoder.decodeSingularMessageField(value: &_storage._expirationTime)
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      switch _storage._id {
      case .fileID(let v)?:
        try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
      case .contractID(let v)?:
        try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
      case nil: break
      }
      if let v = _storage._expirationTime {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 3)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Proto_AdminDeleteTransactionBody, rhs: Proto_AdminDeleteTransactionBody) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._id != rhs_storage._id {return false}
        if _storage._expirationTime != rhs_storage._expirationTime {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
