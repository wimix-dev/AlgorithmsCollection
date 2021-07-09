//
//  File.swift
//
//
//  Created by Vitali Kurlovich on 7.07.21.
//

import Foundation

public
final class KeyedObjectPool<T: AnyObject, Key: Hashable> {
    private var objectPool = [Key: T]()
    public let createObject: (Key) -> T
    public let maxSize: Int

    public
    init(maxSize: Int = 0, createObject: @escaping (Key) -> T) {
        self.maxSize = maxSize
        self.createObject = createObject
        if maxSize > 0 {
            objectPool.reserveCapacity(maxSize)
        }
    }

    public
    func pull(key: Key) -> T {
        if let object = objectPool.removeValue(forKey: key) {
            return object
        }

        if let key = objectPool.first?.key, let object = objectPool.removeValue(forKey: key) {
            return object
        }

        return createObject(key)
    }

    public
    func push(_ object: T, for key: Key) {
        guard maxSize == 0 || objectPool.count < maxSize || objectPool[key] != nil else {
            return
        }

        objectPool[key] = object
    }
}
