//
//  NetworkService.swift
//  PersonsGPSLocation
//
//  Created by Снытин Ростислав on 22.03.2023.
//

import Foundation

class NetworkService: NetworkServiceProtocol {
    static let shared = NetworkService()

    func getPersons(completion: @escaping (([FetchedPerson]) -> Void)) {
        let arrayOfPersons: [FetchedPerson] = [
            FetchedPerson(name: "Ivan Ivanov", avatar: "", location: LocationService.shared.getRandomLocation()),
            FetchedPerson(name: "Petr Petrov", avatar: "", location: LocationService.shared.getRandomLocation()),
            FetchedPerson(name: "Andey Andreev", avatar: "", location: LocationService.shared.getRandomLocation()),
            FetchedPerson(name: "Sidr Sidorov", avatar: "", location: LocationService.shared.getRandomLocation()),
            FetchedPerson(name: "Sergey Sergeev", avatar: "", location: LocationService.shared.getRandomLocation())
        ]
        completion(arrayOfPersons)
    }
}
