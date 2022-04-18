import Foundation
import Combine

enum LocationsViewUnit: UnitType {
    
    typealias CellModel = SomeLocationTableViewCellUnit.ViewModel
    
    struct Input {
        let update: AnyPublisher<Void, Never>
        let selectedIndex: AnyPublisher<IndexPath, Never>
    }
    
    struct Output {
        let navigationBarTitle: AnyPublisher<String?, Never>
        let showActivity: AnyPublisher<Bool, Never>
        let dataSource: AnyPublisher<[CellModel], Never>
        let empty: AnyPublisher<Void, Never>
    }
}

