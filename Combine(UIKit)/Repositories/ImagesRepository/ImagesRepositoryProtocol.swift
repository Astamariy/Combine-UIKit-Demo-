//
//  ImagesRepositoryProtocol.swift
//  Combine(UIKit)
//
//  Created by Рузманов Александр Юрьевич on 15.04.2022.
//

import Combine
import UIKit

protocol ImagesRepositoryProtocol {
    func fetchImage(url: String) -> AnyPublisher<UIImage, Error>
}
