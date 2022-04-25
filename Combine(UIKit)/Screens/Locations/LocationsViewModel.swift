import Foundation
import Combine

final class LocationsViewModel: ViewModelType {

    // MARK: - TypeAlias
    
    typealias Unit = LocationsViewUnit
    
    // MARK: - Model Configuration
    
    struct Configuration {
        let navigationBarTitle: String
    }
    
    // MARK: - Dependencies
    
    struct Dependencies: AutoResolveFactoryMethod {
        let locationRepository: LocationsRepositoryProtocol
        let cellDependencies: SomeLocationTableViewCellModel.Dependencies
    }
    
    // MARK: - Private property
    
    private let configuration: Configuration
    private let dependencies: Dependencies
    private let router: Router
    private let reloadSubject = PassthroughSubject<Void, Never>()
    private let errorSubject = PassthroughSubject<Error, Never>()
    
    // MARK: - Initialization
    
    init(
        dependencies: Dependencies,
        configuration: Configuration,
        router: Router
    ) {
        self.dependencies = dependencies
        self.configuration = configuration
        self.router = router
    }
    
    func transform(input: Unit.Input) -> Unit.Output {
        let updateLocations = Publishers.Merge(input.update, reloadSubject.eraseToAnyPublisher())
        
        let locations = updateLocations
            .prepend(())
            .flatMap(loadLocations)
            .eraseToAnyPublisher()
            .share()
        
        let dataSource = locations
            .map(makeCellModels(for:))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
        let selectedLocationStep = input.selectedIndex
            .withLatestFrom(locations) { $1[$0.row] }
            .map(makeStepFromLocation(location:))
            .handleEvents(receiveOutput: router.navigate(to:))
            .map { _ in }
            .eraseToAnyPublisher()
            
        let errorStep = errorSubject.eraseToAnyPublisher()
            .map(makeStepFromError(error:))
            .handleEvents(receiveOutput: router.navigate(to:))
            .map { _ in }
            .eraseToAnyPublisher()
        
        let empty = Publishers.Merge(selectedLocationStep, errorStep)
            .eraseToAnyPublisher()
        
        return Unit.Output(
            navigationBarTitle: Just(configuration.navigationBarTitle).receive(on: DispatchQueue.main).eraseToAnyPublisher(),
            showActivity: Empty<Bool, Never>().eraseToAnyPublisher(),
            dataSource: dataSource,
            empty: empty
        )
    }
}

// MARK: - ViewModel transform

private extension LocationsViewModel {
    private func loadLocations() -> AnyPublisher<[Location], Never> {
        dependencies.locationRepository.fetchLocations()
            .catch { [errorSubject] error -> AnyPublisher<[Location], Never> in
                errorSubject.send(error)
                return Just([]).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    func makeCellModels(for locations: [Location]) -> [Unit.CellModel] {
        locations.map(makeCellModel(for:))
    }
    
    func makeCellModel(for location: Location) -> Unit.CellModel {
        let eventTracker = SomeLocationTableViewCellModel.EventTracker { [self, location] event in
            switch event {
            case .tap:
                let step = makeStepFromLocation(location: location)
                router.navigate(to: step)
            }
        }
        let config = SomeLocationTableViewCellModel.Configuration(location: location)
        let model = SomeLocationTableViewCellModel(
            dependencies: dependencies.cellDependencies,
            configuration: config,
            eventTracker: eventTracker
        )
        return model.asAnyViewModel()
    }
    
    func makeStepFromLocation(location: Location) -> LocationListRouterStep {
        LocationListRouterStep.weather(url: location.weatherURL)
    }
    func makeStepFromError(error: Error) -> LocationListRouterStep {
        LocationListRouterStep.error(reloadSubject: reloadSubject)
    }
}
