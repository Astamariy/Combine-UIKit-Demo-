//
//  LocationListViewModelProtocol.swift
//  Combine(UIKit)
//
//  Created by Рузманов Александр Юрьевич on 15.04.2022.
//

import Combine
import Foundation

protocol LocationListViewModelProtocol {
    
    // MARK: - Output
    
    var titlePublisher: AnyPublisher<String?, Never> { get }
    var locations: [LocationCellModel] { get }
    var locationsPublisher: AnyPublisher<[LocationCellModel], Never> { get }
    var isLoadingPublisher: AnyPublisher<Bool, Never> { get }
    
    // MARK: - Input
    
    var selectLocationAtIndexPath: PassthroughSubject<IndexPath, Never> { get }
}
