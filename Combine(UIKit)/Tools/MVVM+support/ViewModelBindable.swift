//
//  ViewModelBindable.swift
//  Combine(UIKit)
//
//  Created by Рудаков Евгений on 15.04.2022.
//

import Foundation

protocol ViewModelBindable {
    associatedtype ViewModel
    func bind(viewModel: ViewModel)
}
