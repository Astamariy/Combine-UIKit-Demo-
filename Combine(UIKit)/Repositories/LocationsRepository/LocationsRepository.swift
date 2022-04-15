//
//  LocationsRepository.swift
//  Combine(UIKit)
//
//  Created by Рузманов Александр Юрьевич on 15.04.2022.
//

import Combine
import Foundation

struct LocationsRepository: LocationsRepositoryProtocol {
    
    // MARK: - Private properties
    
    private let locations: [Location] = [
        Location(
            imageURL: "https://www.history.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cq_auto:good%2Cw_1200/MTczMzMzNjYxODgwNDI4NDAz/washington-dc-gettyimages-74063516.jpg",
            name: "Washington, D.C.",
            weatherURL: "https://www.gismeteo.ru/weather-washington-7150/"
        ),
        Location(
            imageURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/47/New_york_times_square-terabass.jpg/500px-New_york_times_square-terabass.jpg",
            name: "New York City",
            weatherURL: "https://www.gismeteo.ru/weather-new-york-7190/"
        ),
        Location(
            imageURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/City_of_Omaha%2C_Nebraska_Skyline_on_the_Missouri_River_%2830899969517%29.jpg/800px-City_of_Omaha%2C_Nebraska_Skyline_on_the_Missouri_River_%2830899969517%29.jpg",
            name: "Omaha, Nebraska",
            weatherURL: "https://www.gismeteo.ru/weather-omaha-7225/"
        ),
        Location(
            imageURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/9/97/Dallas%2C_Texas_Skyline_2005.jpg/400px-Dallas%2C_Texas_Skyline_2005.jpg",
            name: "Dallas",
            weatherURL: "https://www.gismeteo.ru/weather-dallas-7101/"
        ),
        Location(
            imageURL: " ",
            name: "Detroit",
            weatherURL: "не рабочая ссылка"
        ),
        Location(
            imageURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Miamimetroarea.jpg/800px-Miamimetroarea.jpg",
            name: "Miami",
            weatherURL: "https://www.gismeteo.ru/weather-miami-7063/"
        ),
        Location(
            imageURL: "https://cms.finnair.com/resource/blob/1397934/c4410bf39d8838d7285bc25be6d4183b/lax-main-data.jpg",
            name: "Los Angeles",
            weatherURL: "https://www.gismeteo.ru/weather-los-angeles-7116/"
        ),
        Location(
            imageURL: "https://upload.wikimedia.org/wikipedia/commons/d/de/Houston_night.jpg",
            name: "Houston",
            weatherURL: "https://www.gismeteo.ru/weather-houston-7090/"
        ),
        Location(
            imageURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/9/95/Indianapolis-1872528.jpg/1200px-Indianapolis-1872528.jpg",
            name: "Indianapolis",
            weatherURL: "https://www.gismeteo.ru/weather-indianapolis-7166/"
        ),
        Location(
            imageURL: "https://cdn.getyourguide.com/img/location/5ffeb496e3e09.jpeg/88.jpg",
            name: "Las Vegas",
            weatherURL: "https://www.gismeteo.ru/weather-las-vegas-7146/"
        ),
        Location(
            imageURL: "https://cdn.getyourguide.com/img/location/533597d7653a9.jpeg/88.jpg",
            name: "Boston",
            weatherURL: "https://www.gismeteo.ru/weather-boston-7194/"
        ),
    ]
    
    // MARK: - Protocol methods
    
    func fetchLocations() -> AnyPublisher<[Location], Error> {
        Deferred {
            Future<[Location], Error> { future in
                DispatchQueue.global().asyncAfter(deadline: .now() + 2.0) {
                    let isSucceeded = Bool.random()
                    if isSucceeded {
                        future(.success(locations))
                    } else {
                        future(.failure(LocationRepositoryError.someError))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
}
