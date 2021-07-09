//
//  ObjectPool.swift
//  AppUplift
//
//  Created by Vitali Kurlovich on 15.05.21.
//

import Foundation

/**
 Implementation of ObjectPool design pattern

 [Object pool pattern](https://en.wikipedia.org/wiki/Object_pool_pattern)
 */
public
final class ObjectPool<T: AnyObject> {
    private var objectPool = [T]()

    public let maxSize: Int
    public let createObject: () -> T

    /**
     Constructor of `ObjectPool`
     - Parameter maxSize: Limit of the object in the pool if `maxSize` = 0 unlimited size
     - Parameter createObject: Object instantiate block
     */
    public
    init(maxSize: Int = 0, createObject: @escaping () -> T) {
        self.maxSize = maxSize
        self.createObject = createObject
        if maxSize > 0 {
            objectPool.reserveCapacity(maxSize)
        }
    }

    /**
     Pull object from the pool if pool empty instantiate an object
     - Returns: Object instance
     */
    public
    func pull() -> T {
        if objectPool.isEmpty {
            return createObject()
        }

        return objectPool.removeLast()
    }

    /**
     Push instance of object into the pool
     - Parameter object: Instance of object
     */
    public
    func push(_ object: T) {
        guard maxSize == 0 || objectPool.count < maxSize else {
            return
        }

        objectPool.append(object)
    }

    /**
     Push sequence of objects into the pool
     */
    public
    func push<S: Sequence>(contentsOf: S) where S.Element == T {
        guard maxSize == 0 || objectPool.count < maxSize else {
            return
        }

        if maxSize == 0 {
            objectPool.append(contentsOf: contentsOf)
        } else {
            var count = maxSize - objectPool.count
            var iterator = contentsOf.makeIterator()
            while count > 0, let object = iterator.next() {
                count -= 1
                push(object)
            }
        }
    }
}
