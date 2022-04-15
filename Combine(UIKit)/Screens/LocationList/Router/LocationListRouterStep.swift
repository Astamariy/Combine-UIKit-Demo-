//
//  LocationListRouterStep.swift
//  Combine(UIKit)
//
//  Created by Рузманов Александр Юрьевич on 15.04.2022.
//

import Combine

enum LocationListRouterStep: Step {
    case weather(url: String)
    case error(reloadSubject: PassthroughSubject<Void, Never>)
}
