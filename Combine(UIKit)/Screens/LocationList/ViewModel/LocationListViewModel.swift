//
//  LocationListViewModel.swift
//  Combine(UIKit)
//
//  Created by Рузманов Александр Юрьевич on 15.04.2022.
//

import Foundation
import Combine
import UIKit

final class LocationListViewModel: LocationListViewModelProtocol {
    
    // MARK: - Private properties
    
    private let locationsRepository: LocationsRepositoryProtocol
    
    private let imagesRepository: ImagesRepositoryProtocol
    
    private let router: Router
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published private var title: String? = "Локации"
    
    @Published private var isLoading: Bool = true
    
    private var locationsSubject = CurrentValueSubject<[Location], Never>([])
    
    private var reloadSubject = PassthroughSubject<Void, Never>()
    
    // MARK: - Public properties
    
    var titlePublisher: AnyPublisher<String?, Never> {
        $title.eraseToAnyPublisher()
    }
    
    var locations: [LocationCellModel] {
        mapLocations(locationsSubject.value)
    }
    
    var locationsPublisher: AnyPublisher<[LocationCellModel], Never> {
        locationsSubject
            .map { [unowned self] locations in
                mapLocations(locations)
            }
            .eraseToAnyPublisher()
    }
    
    var isLoadingPublisher: AnyPublisher<Bool, Never> {
        $isLoading.eraseToAnyPublisher()
    }
    
    let selectLocationAtIndexPath = PassthroughSubject<IndexPath, Never>()
    
    // MARK: - Initialization
    
    init(
        locationsRepository: LocationsRepositoryProtocol,
        imagesRepository: ImagesRepositoryProtocol,
        router: Router
    ) {
        self.locationsRepository = locationsRepository
        self.imagesRepository = imagesRepository
        self.router = router
        binding()
        fetchLocations()
    }
    
 }

private extension LocationListViewModel {
    
    // MARK: - Binding
    
    func binding() {
        selectLocationAtIndexPath
            .map { [unowned self] indexPath -> Step in
                let location = locationsSubject.value[indexPath.row]
                return LocationListRouterStep.weather(url: location.weatherURL)
            }
            .sink(receiveValue: { [unowned self] step in
                router.navigate(to: step)
            })
            .store(in: &cancellables)
        
        reloadSubject
            .sink(receiveValue: { [unowned self] in
                self.fetchLocations()
            })
            .store(in: &cancellables)
    }
    
    // MARK: - Content
    
    func fetchLocations() {
        isLoading = true
        
        locationsRepository
            .fetchLocations()
            .catch({ [unowned self] error -> AnyPublisher<[Location], Never> in
                router.navigate(to: LocationListRouterStep.error(reloadSubject: reloadSubject))
                return Just([]).eraseToAnyPublisher()
            })
            .sink(receiveValue: { [unowned self] locations in
                self.locationsSubject.send(locations)
                isLoading = false
            })
            .store(in: &cancellables)
    }
    
    func mapLocations(_ locations: [Location]) -> [LocationCellModel] {
        locations.map { location in
            LocationCellModel(
                icon: image(url: location.imageURL),
                name: location.name
            )
        }
    }
    
    func image(url: String) -> AnyPublisher<UIImage, Never> {
        imagesRepository
            .fetchImage(url: url)
            .catch({ error -> AnyPublisher<UIImage, Never> in
                Just(UIImage(named: "city")!).eraseToAnyPublisher()
            })
            .eraseToAnyPublisher()
    }
    
}
