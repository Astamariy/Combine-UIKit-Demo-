//
//  AnyViewModel.swift
//  Combine(UIKit)
//
//  Created by Рудаков Евгений on 15.04.2022.
//

import Foundation

final class AnyViewModel<Input, Output>: ViewModelType {
    private let transformation: (Input) -> Output
    
    init<Model: ViewModelType>(_ model: Model) where Model.Input == Input, Model.Output == Output {
        transformation = model.transform(input:)
    }
    
    func transform(input: Input) -> Output {
        transformation(input)
    }
}
