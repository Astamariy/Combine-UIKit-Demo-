//
//  ImagesRepository.swift
//  Combine(UIKit)
//
//  Created by Рузманов Александр Юрьевич on 15.04.2022.
//

import Combine
import UIKit

struct ImagesRepository: ImagesRepositoryProtocol, AutoAssemblyConst {
    
    // MARK: - Protocol methods
    
    func fetchImage(url: String) -> AnyPublisher<UIImage, Error> {
        guard let url = URL(string: url) else {
            return Fail(error: ImagesRepositoryError.badURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .catch({ error -> AnyPublisher<(data: Data, response: URLResponse), Error> in
                Fail(error: error).eraseToAnyPublisher()
            })
            .flatMap({ result -> AnyPublisher<UIImage, Error> in
                image(data: result.data)
            })
            .eraseToAnyPublisher()
    }
    
}

private extension ImagesRepository {
    
    func image(data: Data) -> AnyPublisher<UIImage, Error> {
        Future { future in
            guard let image = UIImage(data: data) else {
                return future(.failure(ImagesRepositoryError.badData))
            }
            future(.success(image))
        }
        .eraseToAnyPublisher()
    }
}
