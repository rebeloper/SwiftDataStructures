//
//  LinkedList.swift
//  SwiftDataStructures
//
//  Created by Alex Nagy on 01.03.2026.
//

import Foundation

public final class LinkedListNode<Value> {
    
    public var value: Value
    public var next: LinkedListNode?
    
    internal init(value: Value, next: LinkedListNode? = nil) {
        self.value = value
        self.next = next
    }
}

extension LinkedListNode: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String {
        guard let next else {
            return "\(value)"
        }
        return "\(value) -> " + String(describing: next)
    }
    
    public var debugDescription: String {
        guard let next else {
            return "\(value)"
        }
        return "\(value) -> " + String(describing: next)
    }
}

public struct LinkedList<Value> {
    
    public private(set) var head: LinkedListNode<Value>?
    public private(set) var tail: LinkedListNode<Value>?
    
    public init() { }
    
    public var isEmpty: Bool {
        head == nil
    }
    
    public private(set) var count: Int = 0
    public var first: Value? { head?.value }
    public var last: Value? { tail?.value }
    
    @discardableResult
    public mutating func push(_ value: Value) -> LinkedListNode<Value> {
        defer {
            count += 1
        }
        head = LinkedListNode(value: value, next: head)
        if tail == nil {
            tail = head
        }
        return head!
    }
    
    public mutating func append(_ value: Value) {
        guard !isEmpty else {
            push(value)
            return
        }
        
        defer {
            count += 1
        }
        
        tail!.next = LinkedListNode(value: value)
        tail = tail!.next
    }
    
    public func node(at index: Int) -> LinkedListNode<Value>? {
        guard index >= 0 && index < count else { return nil }
        
        var currentNode = head
        var currentIndex = 0
        
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode!.next
            currentIndex += 1
        }
        
        return currentNode
    }
    
    @discardableResult
    public mutating func insert(_ value: Value, after node: LinkedListNode<Value>) -> LinkedListNode<Value> {
        guard tail !== node else {
            append(value)
            return tail!
        }
        
        defer {
            count += 1
        }
        
        node.next = LinkedListNode(value: value, next: node.next)
        return node.next!
    }
    
    @discardableResult
    public mutating func insert(_ value: Value, at index: Int) -> LinkedListNode<Value>? {
        guard index >= 0 && index <= count else { return nil }
        guard index != 0 else { return push(value) }
        guard index != count else {
            append(value)
            return tail
        }
        guard let prev = node(at: index - 1) else { return nil }
        return insert(value, after: prev)
    }
    
    @discardableResult
    public mutating func pop() -> Value? {
        guard let currentHead = head else { return nil }
        
        defer {
            head = currentHead.next
            count -= 1
            if head == nil {
                tail = nil
            }
        }
        
        return currentHead.value
    }
    
    @discardableResult
    public mutating func removeLast() -> Value? {
        guard let head else { return nil }
        guard head.next != nil else { return pop() }
        
        defer {
            count -= 1
        }
        
        var prev = head
        var current = head
        
        while let next = current.next {
            prev = current
            current = next
        }
        
        prev.next = nil
        tail = prev
        return current.value
    }
    
    @discardableResult
    public mutating func remove(after node: LinkedListNode<Value>) -> Value? {
        guard let target = node.next else { return nil }
        
        defer {
            if target === tail {
                tail = node
            }
            node.next = target.next
            count -= 1
        }
        
        return target.value
    }
    
    @discardableResult
    public mutating func remove(at index: Int) -> Value? {
        guard index >= 0 && index < count else { return nil }
        guard index != 0 else { return pop() }
        guard index != count - 1 else {
            return removeLast()
        }
        guard let prev = node(at: index - 1) else { return nil }
        return remove(after: prev)
    }
}

extension LinkedList: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String {
        guard let head else {
            return "Empty list"
        }
        return String(describing: head)
    }
    
    public var debugDescription: String {
        guard let head else {
            return "Empty list"
        }
        return String(describing: head)
    }
}
