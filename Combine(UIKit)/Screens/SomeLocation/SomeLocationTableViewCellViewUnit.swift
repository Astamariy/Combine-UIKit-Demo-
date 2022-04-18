import Foundation
import Combine
import UIKit

enum SomeLocationTableViewCellUnit: UnitType {
    
    enum Event {
        case tap
    }
    
    struct Input {
        let tap: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let image: AnyPublisher<UIImage?, Never>
        let name: AnyPublisher<String?, Never>
        let empty: AnyPublisher<Void, Never>
    }
}

