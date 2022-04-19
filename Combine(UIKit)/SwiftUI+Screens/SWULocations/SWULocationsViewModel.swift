//
//  SWULocationsViewModel.swift
//  Combine(UIKit)
//
//  Created by Рудаков Евгений on 19.04.2022.
//

import Foundation
import Combine

final class SWULocationsViewModel: ObservableObject {
    
    // MARK: - Typealias
    
    typealias Unit = LocationsViewUnit
    typealias ViewModel = Unit.ViewModel
    
    // MARK: - Private properties
    
    private var subscriptions = Set<AnyCancellable>()
    private let selectedIndexPathSubject = PassthroughSubject<IndexPath, Never>()
    
    // MARK: - Public properties
    
    @Published var dataSource = [SWULocationViewModel]()
    
    // MARK: - Public methods
    
    func didSelectItem(item: SWULocationViewModel) {
        selectedIndexPathSubject.send(item.id)
    }
    
    // MARK: - Initialization
    
    init(viewModel: ViewModel) {
        let input = Unit.Input(
            update: Empty().eraseToAnyPublisher(),
            selectedIndex: selectedIndexPathSubject.eraseToAnyPublisher()
        )
        let output = viewModel.transform(input: input)
     
        subscriptions = [
            output.dataSource
                .compactMap { [weak self] in self?.makeSWULocationViewModels(for: $0) }
                .assign(to: \.dataSource, on: self),
            output.empty.sink(receiveValue: {})
        ]
    }
    
}

// MARK: - ViewModel transformation

private extension SWULocationsViewModel {
    func makeSWULocationViewModels(for models: [Unit.CellModel]) -> [SWULocationViewModel] {
        models.enumerated()
            .map { makeSWULocationViewModel(from: $0.element, index: $0.offset) }
    }
    func makeSWULocationViewModel(
        from model: Unit.CellModel,
        index: Int
    ) -> SWULocationViewModel {
        let indexPath = IndexPath(row: index, section: 0)
        let model = SWULocationViewModel(
            viewModel: model,
            indexPath: indexPath
        )
        return  model
    }
}
