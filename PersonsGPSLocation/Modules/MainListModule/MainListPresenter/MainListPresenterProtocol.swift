//
//  MainListPresenterProtocol.swift
//  PersonsGPSLocation
//
//  Created by Снытин Ростислав on 22.03.2023.
//

import Foundation

protocol MainListPresenterProtocol {
    var fetchedPersons: [FetchedPerson] { get set }
    var personsWithDistance: [Person] { get set }
    var selectedPerson: Person? { get set }
    func viewDidLoad()
    func getPersonInHeader(atIndex: Int)
    func deletePersonFromHeader()
}
