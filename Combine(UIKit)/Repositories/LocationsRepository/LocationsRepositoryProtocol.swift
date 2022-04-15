//
//  LocationsRepositoryProtocol.swift
//  Combine(UIKit)
//
//  Created by Рузманов Александр Юрьевич on 15.04.2022.
//

import Combine

protocol LocationsRepositoryProtocol {
    func fetchLocations() -> AnyPublisher<[Location], Error>
}
