//
//  LocationCellModel.swift
//  Combine(UIKit)
//
//  Created by Рузманов Александр Юрьевич on 15.04.2022.
//

import Combine
import UIKit

struct LocationCellModel {
    let icon: AnyPublisher<UIImage, Never>
    let name: String
}
 
