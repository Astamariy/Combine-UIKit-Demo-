//
//  LocationListConfigurator.swift
//  Combine(UIKit)
//
//  Created by Рузманов Александр Юрьевич on 15.04.2022.
//

import SwiftUI
import UIKit

enum LocationListConfigurator {
    
    // MARK: - Public methods
    
    /// UIKit implementation (via storyboard)
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
    
    /// SwiftUI implementation
    static func configure(viewController: LocationListContainerViewController) -> UIHostingController<LocationListView> {
        let locationsRepository = LocationsRepository()
        let imagesRepository = ImagesRepository()
        let router = LocationListRouter(viewController: viewController)
        
        let viewModel = LocationListViewModel(
            locationsRepository: locationsRepository,
            imagesRepository: imagesRepository,
            router: router
        )
        viewController.viewModel = viewModel
        
        let view = LocationListView(viewModel: viewModel)
        let hostingViewController = UIHostingController(rootView: view)
        
        return hostingViewController
    }
    
}
