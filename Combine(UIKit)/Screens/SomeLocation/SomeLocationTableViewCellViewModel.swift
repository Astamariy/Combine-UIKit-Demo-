import Foundation
import Combine
import UIKit

final class SomeLocationTableViewCellModel: ViewModelType {

    // MARK: - TypeAlias
    
    typealias Unit = SomeLocationTableViewCellUnit
    typealias EventTracker = Unit.EventTracker
    
    // MARK: - Constants
    
    private enum Constants {
        static let placeholderImage = UIImage(named: "city")!
    }
    
    // MARK: - Configuration
    
    struct Configuration {
        let location: Location
    }
    
    // MARK: - Dependencies
    
    struct Dependencies {
        let imageRepository: ImagesRepositoryProtocol
    }
    
    // MARK: - Private property
    
    private let dependencies: Dependencies
    private let configuration: Configuration
    private let eventTracker: EventTracker
    
    // MARK: - Initialization
    
    init(
        dependencies: Dependencies,
        configuration: Configuration,
        eventTracker: EventTracker
    ) {
        self.dependencies = dependencies
        self.configuration = configuration
        self.eventTracker = eventTracker
    }
    
    func transform(input: Unit.Input) -> Unit.Output {
        let name = Just(configuration.location.name)
            .map(String?.init)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            
        let image = dependencies.imageRepository
            .fetchImage(url: configuration.location.imageURL)
            .replaceError(with: Constants.placeholderImage)
            .prepend(Constants.placeholderImage)
            .map(UIImage?.init)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
        let tapEvent = input.tap
            .map { Unit.Event.tap }
            .handleEvents(receiveOutput: eventTracker.handle)
            .map { _ in }
            .eraseToAnyPublisher()
        
        return Unit.Output(
            image: image,
            name: name,
            empty: tapEvent
        )
    }
}
