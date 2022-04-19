//
//  SWULocationViewModel.swift
//  Combine(UIKit)
//
//  Created by Рудаков Евгений on 19.04.2022.
//

import Foundation
import UIKit
import Combine

final class SWULocationViewModel: ObservableObject, Identifiable {
    
    // MARK: - Typealias
    
    typealias Unit = SomeLocationTableViewCellUnit
    typealias ViewModel = Unit.ViewModel
    
    // MARK: - Private properties
    
    private var subscriptions = Set<AnyCancellable>()
    private let tapSubject = PassthroughSubject<Void, Never>()
    
    // MARK: - Public properties
    
    @Published var image: UIImage = UIImage(named: "city")!
    @Published var name: String = ""
    
    // MARK: - Protocol properties
    
    var id: IndexPath
    
    // MARK: - Initialization
    
    init(
        viewModel: ViewModel,
        indexPath: IndexPath
    ) {
        self.id = indexPath
        
        let input = Unit.Input(
            tap: tapSubject.eraseToAnyPublisher()
        )
        let output = viewModel.transform(input: input)
        subscriptions = [
            output.image.compactMap { $0 }.assign(to: \.image, on: self),
            output.name.compactMap { $0 }.assign(to: \.name, on: self),
            output.empty.sink(receiveValue: {})
        ]
    }
    
    func buttonTap() {
        tapSubject.send(())
    }
}
