//
//  PokemonCollectionViewCell.swift
//  Pokedex
//
//  Created by David Felipe Cortes Gonzalez on 23/07/24.
//

import UIKit
import SDWebImage

class PokemonCollectionViewCell: UICollectionViewCell {
    // MARK: var - let
    static let identifier: String = "PokemonCollectionViewCell"
    
    // MARK: Private var -let
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: View lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configView()
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configView()
        setupAppearance()
    }
    
    // MARK: public func
    func configure(with imageUrl: String?, name: String) {
        if let imageUrl = imageUrl {
            if let url = URL(string: imageUrl) {
                imageView.sd_setImage(with: url, placeholderImage: Images.placeHolder.image)
            } else {
                imageView.image = Images.placeHolder.image
            }
        }
        nameLabel.text = name
    }
    
    // MARK: Private func
    private func configView() {
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    private func setupAppearance() {
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.masksToBounds = false
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowOffset = CGSize(width: 0, height: 1)
        contentView.layer.shadowRadius = 4
        contentView.backgroundColor = .white
    }
}
