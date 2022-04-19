//
//  SWULocationsSceneFactory.swift
//  Combine(UIKit)
//
//  Created by Рудаков Евгений on 19.04.2022.
//

import Foundation
import UIKit
import SwiftUI

enum SWULocationsSceneFactory {
    static func makeScene(router: Router) -> UIViewController {
        let viewModel = LocationsViewModel(
            dependencies: .init(
                locationRepository: LocationsRepository(),
                cellDependencies: .init(imageRepository: ImagesRepository())
            ),
            configuration: .init(navigationBarTitle: "Nihao"),
            router: router
        )
        let swuViewModel = SWULocationsViewModel(viewModel: viewModel.asAnyViewModel())
        let view = SWULocationsView(viewModel: swuViewModel)
        let viewController = UIHostingController(rootView: view)
        return viewController
    }
}
