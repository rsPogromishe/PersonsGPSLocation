//
//  MainListAssemble.swift
//  PersonsGPSLocation
//
//  Created by Снытин Ростислав on 22.03.2023.
//

import UIKit

class MainListAssemble {
    static func assembleMainListModule() -> UIViewController {
        let presenter = MainListPresenter()
        let view = MainListViewController(presenter: presenter)
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
