//
//  NetworkServiceProtocol.swift
//  PersonsGPSLocation
//
//  Created by Снытин Ростислав on 22.03.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    func getPersons(completion: @escaping (([FetchedPerson]) -> Void))
}
