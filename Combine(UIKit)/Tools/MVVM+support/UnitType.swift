//
//  UnitType.swift
//  Combine(UIKit)
//
//  Created by Рудаков Евгений on 15.04.2022.
//

import Foundation

protocol UnitType {
    associatedtype Input
    associatedtype Output
}

extension UnitType {
    typealias ViewModel = AnyViewModel<Input, Output>
}
