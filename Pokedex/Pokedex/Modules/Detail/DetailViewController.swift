//
//  DetailViewController.swift
//  Created by David Felipe Cortes Gonzalez on 24/07/24.
//  Copyright (c) 2024. All rights reserved.

import UIKit
import SDWebImage

final class DetailViewController: UIViewController {
    
    // MARK: - Properties
    var presenter: DetailPresenterProtocol?
    
    // MARK: - Private Properties
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var abilitiesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, nameLabel, descriptionLabel, abilitiesLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        presenter?.viewDidLoad()
    }
    
    // MARK: - Private Methods
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(stackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 120),
        ])
    }
    
    // MARK: - Public Methods

}

// MARK: - DetailViewProtocol
extension DetailViewController: DetailViewProtocol {
    func showError() {
        print("Error loading Pokémon details")
    }
    
    func updateView(with pokemonData: PokemonData) {
        if let imageUrl = URL(string: pokemonData.imageURL) {
            imageView.sd_setImage(with: imageUrl, placeholderImage: Images.placeHolder.image)
        } else {
            imageView.image = Images.placeHolder.image
        }
        nameLabel.text = pokemonData.name
        descriptionLabel.text = pokemonData.description
        abilitiesLabel.text = "Abilities: " + pokemonData.abilities.joined(separator: ", ")
    }
}

