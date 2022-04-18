//
//  EventTrackerType.swift
//  Combine(UIKit)
//
//  Created by Рудаков Евгений on 16.04.2022.
//

import Foundation

protocol EventTrackerType {
    associatedtype Event
    func handle(event: Event)
}

extension EventTrackerType {
    func asAnyEventTracker() -> AnyEventTracker<Event> {
        AnyEventTracker<Event>(self)
    }
}
