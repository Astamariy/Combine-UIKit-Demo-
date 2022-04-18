//
//  Runnable.swift
//  Combine(UIKit)
//
//  Created by Рудаков Евгений on 16.04.2022.
//

import Foundation

public protocol Runnable { }

public extension Runnable {
    @discardableResult
    func run<T>(closure: (Self) -> T) -> T {
        return closure(self)
    }
}

// MARK: - NSObject implement Runnable

extension NSObject: Runnable { }
