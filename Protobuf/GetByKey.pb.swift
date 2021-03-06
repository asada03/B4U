// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: GetByKey.proto
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

/// Get all accounts, claims, files, and smart contract instances whose associated keys include the given Key. The given Key must not be a contractID or a ThresholdKey. This is not yet implemented in the API, but will be in the future. 
struct Proto_GetByKeyQuery {
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

  /// the key to search for. It must not contain a contractID nor a ThresholdSignature.
  var key: Proto_Key {
    get {return _storage._key ?? Proto_Key()}
    set {_uniqueStorage()._key = newValue}
  }
  /// Returns true if `key` has been explicitly set.
  var hasKey: Bool {return _storage._key != nil}
  /// Clears the value of `key`. Subsequent reads from it will return its default value.
  mutating func clearKey() {_uniqueStorage()._key = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

/// the ID for a single entity (account, claim, file, or smart contract instance) 
struct Proto_EntityID {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var entity: OneOf_Entity? {
    get {return _storage._entity}
    set {_uniqueStorage()._entity = newValue}
  }

  /// a cryptocurrency account
  var accountID: Proto_AccountID {
    get {
      if case .accountID(let v)? = _storage._entity {return v}
      return Proto_AccountID()
    }
    set {_uniqueStorage()._entity = .accountID(newValue)}
  }

  /// a claim attached to an account
  var claim: Proto_Claim {
    get {
      if case .claim(let v)? = _storage._entity {return v}
      return Proto_Claim()
    }
    set {_uniqueStorage()._entity = .claim(newValue)}
  }

  /// a file
  var fileID: Proto_FileID {
    get {
      if case .fileID(let v)? = _storage._entity {return v}
      return Proto_FileID()
    }
    set {_uniqueStorage()._entity = .fileID(newValue)}
  }

  /// a smart contract instance
  var contractID: Proto_ContractID {
    get {
      if case .contractID(let v)? = _storage._entity {return v}
      return Proto_ContractID()
    }
    set {_uniqueStorage()._entity = .contractID(newValue)}
  }

  var unknownFields = SwiftProtobuf.UnknownStorage()

  enum OneOf_Entity: Equatable {
    /// a cryptocurrency account
    case accountID(Proto_AccountID)
    /// a claim attached to an account
    case claim(Proto_Claim)
    /// a file
    case fileID(Proto_FileID)
    /// a smart contract instance
    case contractID(Proto_ContractID)

  #if !swift(>=4.1)
    static func ==(lhs: Proto_EntityID.OneOf_Entity, rhs: Proto_EntityID.OneOf_Entity) -> Bool {
      switch (lhs, rhs) {
      case (.accountID(let l), .accountID(let r)): return l == r
      case (.claim(let l), .claim(let r)): return l == r
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

/// Response when the client sends the node GetByKeyQuery 
struct Proto_GetByKeyResponse {
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

  /// list of entities that include this public key in their associated Key list
  var entities: [Proto_EntityID] {
    get {return _storage._entities}
    set {_uniqueStorage()._entities = newValue}
  }

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "proto"

extension Proto_GetByKeyQuery: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    func _protobuf_generated_isEqualTo(other: Proto_GetByKeyQuery) -> Bool {
        return false
    }
    
  static let protoMessageName: String = _protobuf_package + ".GetByKeyQuery"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "header"),
    2: .same(proto: "key"),
  ]

  fileprivate class _StorageClass {
    var _header: Proto_QueryHeader? = nil
    var _key: Proto_Key? = nil

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _header = source._header
      _key = source._key
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
        case 2: try decoder.decodeSingularMessageField(value: &_storage._key)
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
      if let v = _storage._key {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Proto_GetByKeyQuery, rhs: Proto_GetByKeyQuery) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._header != rhs_storage._header {return false}
        if _storage._key != rhs_storage._key {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Proto_EntityID: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    func _protobuf_generated_isEqualTo(other: Proto_EntityID) -> Bool {
        return false
    }
    
  static let protoMessageName: String = _protobuf_package + ".EntityID"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "accountID"),
    2: .same(proto: "claim"),
    3: .same(proto: "fileID"),
    4: .same(proto: "contractID"),
  ]

  fileprivate class _StorageClass {
    var _entity: Proto_EntityID.OneOf_Entity?

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _entity = source._entity
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
          var v: Proto_AccountID?
          if let current = _storage._entity {
            try decoder.handleConflictingOneOf()
            if case .accountID(let m) = current {v = m}
          }
          try decoder.decodeSingularMessageField(value: &v)
          if let v = v {_storage._entity = .accountID(v)}
        case 2:
          var v: Proto_Claim?
          if let current = _storage._entity {
            try decoder.handleConflictingOneOf()
            if case .claim(let m) = current {v = m}
          }
          try decoder.decodeSingularMessageField(value: &v)
          if let v = v {_storage._entity = .claim(v)}
        case 3:
          var v: Proto_FileID?
          if let current = _storage._entity {
            try decoder.handleConflictingOneOf()
            if case .fileID(let m) = current {v = m}
          }
          try decoder.decodeSingularMessageField(value: &v)
          if let v = v {_storage._entity = .fileID(v)}
        case 4:
          var v: Proto_ContractID?
          if let current = _storage._entity {
            try decoder.handleConflictingOneOf()
            if case .contractID(let m) = current {v = m}
          }
          try decoder.decodeSingularMessageField(value: &v)
          if let v = v {_storage._entity = .contractID(v)}
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      switch _storage._entity {
      case .accountID(let v)?:
        try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
      case .claim(let v)?:
        try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
      case .fileID(let v)?:
        try visitor.visitSingularMessageField(value: v, fieldNumber: 3)
      case .contractID(let v)?:
        try visitor.visitSingularMessageField(value: v, fieldNumber: 4)
      case nil: break
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Proto_EntityID, rhs: Proto_EntityID) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._entity != rhs_storage._entity {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Proto_GetByKeyResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    func _protobuf_generated_isEqualTo(other: Proto_GetByKeyResponse) -> Bool {
        return false
    }
    
  static let protoMessageName: String = _protobuf_package + ".GetByKeyResponse"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "header"),
    2: .same(proto: "entities"),
  ]

  fileprivate class _StorageClass {
    var _header: Proto_ResponseHeader? = nil
    var _entities: [Proto_EntityID] = []

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _header = source._header
      _entities = source._entities
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
        case 2: try decoder.decodeRepeatedMessageField(value: &_storage._entities)
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
      if !_storage._entities.isEmpty {
        try visitor.visitRepeatedMessageField(value: _storage._entities, fieldNumber: 2)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Proto_GetByKeyResponse, rhs: Proto_GetByKeyResponse) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._header != rhs_storage._header {return false}
        if _storage._entities != rhs_storage._entities {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
