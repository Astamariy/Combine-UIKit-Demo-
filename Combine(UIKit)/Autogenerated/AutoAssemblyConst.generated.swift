// Generated using Sourcery 1.8.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import Foundation
import Swinject

// swiftlint:disable all

// MARK: - ImagesRepository + Assembly

final class ImagesRepositoryAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ImagesRepositoryProtocol.self) { resolver in
            ImagesRepository()
        }
    }
}

// MARK: - LocationsRepository + Assembly

final class LocationsRepositoryAssembly: Assembly {
    func assemble(container: Container) {
        container.register(LocationsRepositoryProtocol.self) { resolver in
            LocationsRepository()
        }
    }
}

enum ConstAssembler {
    static func make() -> Assembler {
        Assembler([
            ImagesRepositoryAssembly(),
            LocationsRepositoryAssembly()
        ])
    }
}

// swiftlint:enable all
