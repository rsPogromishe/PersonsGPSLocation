//
//  MainListViewInput.swift
//  PersonsGPSLocation
//
//  Created by Снытин Ростислав on 22.03.2023.
//

import Foundation

protocol MainListViewInput: AnyObject {
    func reloadData()
    func showAlertOfLocation()
}
