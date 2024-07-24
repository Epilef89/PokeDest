//
//  HomeViewController.swift
//  Created by David Felipe Cortes Gonzalez on 23/07/24.
//  Copyright (c) 2024. All rights reserved.

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    var presenter: HomePresenterProtocol?
    
    // MARK: - Private Properties
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: PokemonCollectionViewCell.identifier)
        return collectionView
    }()
    
    private lazy var columnSwitch: UISwitch = {
        let switchControl = UISwitch()
        switchControl.isOn = true
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        switchControl.addTarget(self, action: #selector(didChangeSwitchValue(_:)), for: .valueChanged)
        return switchControl
    }()
    
    private lazy var switchLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Two Columns"
        return label
    }()
    
    private var isTwoColumn: Bool = true {
        didSet {
            configureCollectionViewLayout(for: collectionView.collectionViewLayout as! UICollectionViewFlowLayout, isTwoColumn: isTwoColumn)
            collectionView.reloadData()
        }
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        configureCollectionViewLayout(for: collectionView.collectionViewLayout as! UICollectionViewFlowLayout, isTwoColumn: true)
        presenter?.viewDidLoad()
    }
    
    // MARK: - Private Methods
    private func setupView() {
        view.addSubview(collectionView)
        view.addSubview(columnSwitch)
        view.addSubview(switchLabel)
        view.backgroundColor = .white
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            switchLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            switchLabel.centerYAnchor.constraint(equalTo: columnSwitch.centerYAnchor),
            columnSwitch.leadingAnchor.constraint(equalTo: switchLabel.trailingAnchor, constant: 8),
            columnSwitch.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            collectionView.topAnchor.constraint(equalTo: columnSwitch.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureCollectionViewLayout(for layout: UICollectionViewFlowLayout, isTwoColumn: Bool) {
        let spacing: CGFloat = 16
        let width = view.bounds.width - (2 * spacing)
        if isTwoColumn {
            let itemWidth = (width - spacing) / 2
            layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        } else {
            let itemWidth = width
            layout.itemSize = CGSize(width: itemWidth, height: itemWidth / 2)
        }
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
    }
    
    @objc private func didChangeSwitchValue(_ sender: UISwitch) {
        isTwoColumn = sender.isOn
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfPokemons() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.identifier, for: indexPath) as? PokemonCollectionViewCell,
              let pokemon = presenter?.pokemon(at: indexPath.row) else {
            return UICollectionViewCell()
        }
        cell.configure(with: pokemon.imageURL, name: pokemon.name)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        if contentOffsetY > contentHeight - frameHeight {
            presenter?.loadMorePokemons()
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.showDetail(at: indexPath.row)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
}

// MARK: HomeViewProtocol
extension HomeViewController: HomeViewProtocol {
    func showError() {
        print("error")
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
}
