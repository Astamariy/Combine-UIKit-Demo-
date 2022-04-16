import Foundation

enum LocationsConfigurator {

    // MARK: - Public methods

    static func configure(
        viewController: LocationsViewController,
        configuration: LocationsViewModel.Configuration,
        router: Router
    ) {
        let cellDependencies = SomeLocationTableViewCellModel.Dependencies(
            imageRepository: ImagesRepository()
        )
        let dependencies = LocationsViewModel.Dependencies(
            locationRepository: LocationsRepository(),
            cellDependencies: cellDependencies
        )

        let viewModel = LocationsViewModel(
            dependencies: dependencies,
            configuration: configuration,
            router: router
        )

        viewController.viewModel = viewModel.asAnyViewModel()
    }

}
