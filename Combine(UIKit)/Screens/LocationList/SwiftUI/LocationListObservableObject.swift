//
//  LocationListObservableObject.swift
//  Combine(UIKit)
//
//  Created by Рузманов Александр Юрьевич on 18.04.2022.
//

import Combine
import Foundation

final class LocationListObservableObject: ObservableObject {
    
    // MARK: - Private properties
    
    private let viewModel: LocationListViewModelProtocol
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Public poperties
    
    @Published var isLoading: Bool = true
    
    @Published var locations: [LocationCellModel] = []
    
    let didSelectLocation = PassthroughSubject<LocationCellModel, Never>()
    
    // MARK: - Initialization
    
    init(viewModel: LocationListViewModelProtocol) {
        self.viewModel = viewModel
        binding()
    }
    
}

// MARK: - Private methods

private extension LocationListObservableObject {
    
    func binding() {
        viewModel
            .locationsPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.locations, on: self)
            .store(in: &cancellables)
        
        viewModel
            .isLoadingPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.isLoading, on: self)
            .store(in: &cancellables)
        
        didSelectLocation
            .compactMap { [unowned self] location in
                return locations.firstIndex(where: { location.id == $0.id })
            }
            .map { IndexPath(row: $0, section: 0) }
            .sink { [unowned self] indexPath in
                viewModel.selectLocationAtIndexPath.send(indexPath)
            }
            .store(in: &cancellables)
    }
}
