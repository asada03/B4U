// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: TransactionResponse.proto
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

/// When the node receives a transaction from a client, it performs a precheck, to see if if the transaction is correctly formed, and if the account has sufficient cryptocurrency to pay the transaction fee. If it passes the precheck, then the node will send it to the network for processing.  The node will always reply to a transaction with the TransactionResponse, which indicates whether it passed the precheck, or why it failed. 
enum Proto_NodeTransactionPrecheckCode: SwiftProtobuf.Enum {
  typealias RawValue = Int

  /// the transaction passed the precheck
  case ok // = 0

  /// the transaction had incorrect syntax or other errors
  case invalidTransaction // = 1

  /// the payer account or node account isn't a valid account number
  case invalidAccount // = 2

  /// the transaction fee is insufficient for this type of transaction
  case insufficientFee // = 3

  /// the payer account has insufficient cryptocurrency to pay the transaction fee
  case insufficientBalance // = 4

  /// this transaction ID is a duplicate of one that was submitted to this node or reached consensus in the last 180 seconds (receipt period)
  case duplicate // = 5

  ///If API is throttled out
  case busy // = 6

  ///not supported API
  case notSupported // = 7
  case UNRECOGNIZED(Int)

  init() {
    self = .ok
  }

  init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .ok
    case 1: self = .invalidTransaction
    case 2: self = .invalidAccount
    case 3: self = .insufficientFee
    case 4: self = .insufficientBalance
    case 5: self = .duplicate
    case 6: self = .busy
    case 7: self = .notSupported
    default: self = .UNRECOGNIZED(rawValue)
    }
  }

  var rawValue: Int {
    switch self {
    case .ok: return 0
    case .invalidTransaction: return 1
    case .invalidAccount: return 2
    case .insufficientFee: return 3
    case .insufficientBalance: return 4
    case .duplicate: return 5
    case .busy: return 6
    case .notSupported: return 7
    case .UNRECOGNIZED(let i): return i
    }
  }

}

#if swift(>=4.2)

extension Proto_NodeTransactionPrecheckCode: CaseIterable {
  // The compiler won't synthesize support with the UNRECOGNIZED case.
  static var allCases: [Proto_NodeTransactionPrecheckCode] = [
    .ok,
    .invalidTransaction,
    .invalidAccount,
    .insufficientFee,
    .insufficientBalance,
    .duplicate,
    .busy,
    .notSupported,
  ]
}

#endif  // swift(>=4.2)

/// When the client sends the node a transaction of any kind, the node replies with this, which simply says that the transaction passed the precheck (so the node will submit it to the network) or it failed (so it won't). To learn the consensus result, the client should later obtain a receipt (free), or can buy a more detailed record (not free). 
struct Proto_TransactionResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// whether the transaction passed the precheck, or why it failed
  var nodeTransactionPrecheckCode: Proto_NodeTransactionPrecheckCode = .ok

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "proto"

extension Proto_NodeTransactionPrecheckCode: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "OK"),
    1: .same(proto: "INVALID_TRANSACTION"),
    2: .same(proto: "INVALID_ACCOUNT"),
    3: .same(proto: "INSUFFICIENT_FEE"),
    4: .same(proto: "INSUFFICIENT_BALANCE"),
    5: .same(proto: "DUPLICATE"),
    6: .same(proto: "BUSY"),
    7: .same(proto: "NOT_SUPPORTED"),
  ]
}

extension Proto_TransactionResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    func _protobuf_generated_isEqualTo(other: Proto_TransactionResponse) -> Bool {
        return false
    }
    
  static let protoMessageName: String = _protobuf_package + ".TransactionResponse"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "nodeTransactionPrecheckCode"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularEnumField(value: &self.nodeTransactionPrecheckCode)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.nodeTransactionPrecheckCode != .ok {
      try visitor.visitSingularEnumField(value: self.nodeTransactionPrecheckCode, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Proto_TransactionResponse, rhs: Proto_TransactionResponse) -> Bool {
    if lhs.nodeTransactionPrecheckCode != rhs.nodeTransactionPrecheckCode {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
