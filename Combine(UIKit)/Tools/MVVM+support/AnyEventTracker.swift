//
//  AnyEventTracker.swift
//  Combine(UIKit)
//
//  Created by Рудаков Евгений on 16.04.2022.
//

import Foundation

final class AnyEventTracker<Event>: EventTrackerType {
    private let completion: (Event) -> Void
    
    init(_ completion: @escaping (Event) -> Void) {
        self.completion = completion
    }
    
    init<EventTracker: EventTrackerType>(_ router: EventTracker) where EventTracker.Event == Event {
        completion = router.handle(event:)
    }
    
    func handle(event: Event) {
        completion(event)
    }
}
