// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

struct LogStore {
    static var log: [String] = []
}

public func printLog(_ string: String) {
    print(string)
    
    LogStore.log.append(string)
}
