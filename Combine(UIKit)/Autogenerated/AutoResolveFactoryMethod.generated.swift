// Generated using Sourcery 1.8.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import Foundation
import Swinject

// swiftlint:disable all

// MARK: - LocationsViewModel.Dependencies + Resolve

extension LocationsViewModel.Dependencies {
    static func resolve(with resolver: Resolver) -> LocationsViewModel.Dependencies {
        LocationsViewModel.Dependencies(
            locationRepository: resolver.resolve(LocationsRepositoryProtocol.self)!,
            cellDependencies: SomeLocationTableViewCellModel.Dependencies.resolve(with: resolver)
        )
    }
}

// MARK: - SomeLocationTableViewCellModel.Dependencies + Resolve

extension SomeLocationTableViewCellModel.Dependencies {
    static func resolve(with resolver: Resolver) -> SomeLocationTableViewCellModel.Dependencies {
        SomeLocationTableViewCellModel.Dependencies(
            imageRepository: resolver.resolve(ImagesRepositoryProtocol.self)!
        )
    }
}

// swiftlint:enable all
