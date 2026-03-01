//
//  Stack.swift
//  SwiftDataStructures
//
//  Created by Alex Nagy on 01.03.2026.
//

import Foundation

public struct Stack<Element> {
    
    private var storage: [Element] = []
    
    public var isEmpty: Bool {
        storage.isEmpty
    }
    
    public var count: Int {
        storage.count
    }
    
    public init() { }
    
    public init(_ elements: [Element]) {
        storage = elements
    }
    
    public mutating func push(_ element: Element) {
        storage.append(element)
    }
    
    @discardableResult
    public mutating func pop() -> Element? {
        storage.popLast()
    }
    
    public func peek() -> Element? {
        storage.last
    }
    
    public mutating func clear() {
        storage.removeAll()
    }
    
    public func toArray() -> [Element] {
        storage
    }
}

extension Stack: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String {
        """
        ---top---
        \(storage.map { "\($0)" }.reversed().joined(separator: "\n"))
        ---------
        """
    }
    
    public var debugDescription: String {
        """
        ---top---
        \(storage.map { "\($0)" }.reversed().joined(separator: "\n"))
        ---------
        """
    }
}

extension Stack: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        storage = elements
    }
}
