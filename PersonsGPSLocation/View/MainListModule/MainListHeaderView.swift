//
//  MainListHeaderView.swift
//  PersonsGPSLocation
//
//  Created by Снытин Ростислав on 22.03.2023.
//

import UIKit

class MainListHeaderView: UIView {
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let avatarImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.tintColor = .lightGray
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(personData: Person) {
        nameLabel.text = personData.name
        avatarImage.image = UIImage(systemName: "person.fill")
        distanceLabel.text = "Distance: ~\(Int(personData.distance)) km."
        setupUI()
        isUserInteractionEnabled = true
        backgroundColor = .secondarySystemBackground
    }

    private func setupUI() {
        addSubview(nameLabel)
        addSubview(avatarImage)
        addSubview(distanceLabel)

        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            avatarImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            avatarImage.heightAnchor.constraint(equalToConstant: 50),
            avatarImage.widthAnchor.constraint(equalTo: avatarImage.heightAnchor),

            nameLabel.leftAnchor.constraint(equalTo: avatarImage.rightAnchor, constant: 10),
            nameLabel.topAnchor.constraint(equalTo: avatarImage.topAnchor),

            distanceLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            distanceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            distanceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
