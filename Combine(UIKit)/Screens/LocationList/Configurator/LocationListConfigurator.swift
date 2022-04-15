//
//  LocationListConfigurator.swift
//  Combine(UIKit)
//
//  Created by Рузманов Александр Юрьевич on 15.04.2022.
//

import Foundation

enum LocationListConfigurator {
    
    // MARK: - Public methods
    
    static func configure(viewController: LocationListViewController) {
        let locationsRepository = LocationsRepository()
        let imagesRepository = ImagesRepository()
        let router = LocationListRouter(viewController: viewController)
        
        let viewModel = LocationListViewModel(
            locationsRepository: locationsRepository,
            imagesRepository: imagesRepository,
            router: router
        )
        
        viewController.viewModel = viewModel
    }
    
}
