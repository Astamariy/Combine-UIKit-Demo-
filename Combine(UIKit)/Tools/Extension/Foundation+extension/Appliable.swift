//
//  Appliable.swift
//  Combine(UIKit)
//
//  Created by Рудаков Евгений on 16.04.2022.
//

import Foundation

public protocol Appliable { }

public extension Appliable {
    @discardableResult
    func apply(closure: (Self) -> Void) -> Self {
        closure(self)
        return self
    }
}

// MARK: - NSObject implement Applicable

extension NSObject: Appliable { }
