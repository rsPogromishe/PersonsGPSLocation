//
//  File.swift
//  PersonsGPSLocation
//
//  Created by Снытин Ростислав on 22.03.2023.
//

import Foundation
import CoreLocation

class MainListPresenter: MainListPresenterProtocol {
    weak var view: MainListViewInput?

    private let locationManager = CLLocationManager()

    var fetchedPersons = [FetchedPerson]()
    var personsWithDistance = [Person]()
    var selectedPerson: Person?
    private var currentLocation: CLLocation?
    private var indexOfSelectedPerson: Int?
    private var timer: Timer?

    func viewDidLoad() {
        getPersons()
        locationManager.requestWhenInUseAuthorization()
        currentLocation = locationManager.location
        checkLocationServices()
    }

    func getPersonInHeader(atIndex: Int) {
        if selectedPerson == nil {
            indexOfSelectedPerson = atIndex
            selectedPerson = personsWithDistance[atIndex]
            personsWithDistance.remove(at: atIndex)
            sortPersons()
            view?.reloadData()
        }
    }

    func deletePersonFromHeader() {
        personsWithDistance.insert(
            selectedPerson ?? Person(name: "", distance: 0, avatar: ""),
            at: indexOfSelectedPerson ?? 0
        )
        selectedPerson = nil
        sortPersons()
        view?.reloadData()
    }

    private func setupTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { (_) in
            self.getPersons()
        })
    }

    private func getPersons() {
        NetworkService.shared.getPersons { [weak self] persons in
            guard let self = self else { return }
            self.fetchedPersons = persons
            self.sortPersons()
            self.setupTimer()
            self.view?.reloadData()
        }
    }

    private func sortPersons() {
        personsWithDistance.removeAll()
        let location = selectedPerson != nil ? fetchedPersons[indexOfSelectedPerson ?? 0].location :
                                                currentLocation ?? CLLocation()
        fetchedPersons.forEach { person in
            if person.name != selectedPerson?.name {
                let distance = person.location.distance(from: location) / 1000
                personsWithDistance.append(Person(name: person.name, distance: distance, avatar: person.avatar))
            }
        }
        /* При обновлении:
         у закрепленного персонажа продолжается обновляться дистанция относительно геолокации пользователя
         */
        if selectedPerson != nil {
            selectedPerson?.distance =
            fetchedPersons[indexOfSelectedPerson ?? 0].location.distance(from: currentLocation ?? CLLocation()) / 1000
        }
        view?.reloadData()
    }

    private func checkLocationServices() {
        DispatchQueue.global().async {
            if !CLLocationManager.locationServicesEnabled() {
                self.view?.showAlertOfLocation()
            } else {
                self.currentLocation = self.locationManager.location
            }
        }
    }
}
