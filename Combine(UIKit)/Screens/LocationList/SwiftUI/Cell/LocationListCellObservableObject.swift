//
//  LocationListCellObservableObject.swift
//  Combine(UIKit)
//
//  Created by Рузманов Александр Юрьевич on 18.04.2022.
//

import Combine
import Foundation
import UIKit

final class LocationListCellObservableObject: ObservableObject {
    
    // MARK: - Private properties
    
    private let model: LocationCellModel
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Public poperties
    
    @Published var icon: UIImage = UIImage()
    
    @Published var name: String = ""
    
    // MARK: - Initialization
    
    init(model: LocationCellModel) {
        self.model = model
        binding()
    }
    
}

// MARK: - Private methods

private extension LocationListCellObservableObject {
    
    func binding() {
        model
            .icon
            .receive(on: DispatchQueue.main)
            .assign(to: \.icon, on: self)
            .store(in: &cancellables)
        
        name = model.name
    }
}
