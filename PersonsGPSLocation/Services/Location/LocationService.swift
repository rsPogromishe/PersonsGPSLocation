//
//  LocationService.swift
//  PersonsGPSLocation
//
//  Created by Снытин Ростислав on 21.03.2023.
//

import Foundation
import CoreLocation

class LocationService {
    static let shared = LocationService()

    func getRandomLocation() -> CLLocation {
        let randomLatitudeOffset = Double.random(in: 55.0001...55.5)
        let randomLongitudeOffset = Double.random(in: 37.0001...37.4)

        let locationWithOffset = CLLocation(
            latitude: randomLatitudeOffset,
            longitude: randomLongitudeOffset
        )
        return locationWithOffset
    }
}
