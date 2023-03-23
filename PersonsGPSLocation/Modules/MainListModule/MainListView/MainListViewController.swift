//
//  ViewController.swift
//  PersonsGPSLocation
//
//  Created by Снытин Ростислав on 21.03.2023.
//

import UIKit

class MainListViewController: UIViewController {
    var presenter: MainListPresenter

    private let listOfPersonsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()

    init(presenter: MainListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = "Person's GPS Location"
        view.backgroundColor = .white
        setupUI()
        setupTableView()
        presenter.viewDidLoad()
    }

    @objc private func headerTapped() {
        presenter.deletePersonFromHeader()
    }
}

// MARK: TableView Delegate/DataSource

extension MainListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.personsWithDistance.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: MainListTableViewCell.identifier,
            for: indexPath
        ) as? MainListTableViewCell {
            cell.configure(personData: presenter.personsWithDistance[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.getPersonInHeader(atIndex: indexPath.row)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        presenter.selectedPerson != nil ? 80 : 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = MainListHeaderView()
        view.configure(personData: presenter.selectedPerson ?? Person(name: "", distance: 0, avatar: ""))
        let tap = UITapGestureRecognizer(target: self, action: #selector(headerTapped))
        view.addGestureRecognizer(tap)
        return view
    }
}

// MARK: MainList ViewInput

extension MainListViewController: MainListViewInput {
    func reloadData() {
        listOfPersonsTableView.reloadData()
    }

    func showAlertOfLocation() {
        let alertAction = UIAlertController(
            title: "Your location is not available",
            message: "To give permission go to: Settings -> PersonsGPSLocation -> Location",
            preferredStyle: .alert
        )
        let actionOK = UIAlertAction(title: "OK", style: .default, handler: nil)

        alertAction.addAction(actionOK)
        present(alertAction, animated: true)
    }
}

// MARK: Setup UI

extension MainListViewController {
    private func setupUI() {
        view.addSubview(listOfPersonsTableView)

        NSLayoutConstraint.activate([
            listOfPersonsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            listOfPersonsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            listOfPersonsTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            listOfPersonsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupTableView() {
        listOfPersonsTableView.delegate = self
        listOfPersonsTableView.dataSource = self
        listOfPersonsTableView.register(
            MainListTableViewCell.self,
            forCellReuseIdentifier: MainListTableViewCell.identifier
        )
    }
}
