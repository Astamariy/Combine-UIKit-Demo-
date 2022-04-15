//
//  ViewModelType.swift
//  Combine(UIKit)
//
//  Created by Рудаков Евгений on 15.04.2022.
//

import Foundation

protocol ViewModelType {
    associatedtype Unit: UnitType = AnyUnit<Input, Output> where Unit.Input == Input, Unit.Output == Output
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

extension ViewModelType {
    func asAnyViewModel() -> AnyViewModel<Input, Output> {
        AnyViewModel<Input, Output>(self)
    }
}
