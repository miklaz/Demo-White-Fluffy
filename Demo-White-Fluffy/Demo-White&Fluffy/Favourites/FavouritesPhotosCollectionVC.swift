//
//  FavouritesPhotosCollectionVC.swift
//  Demo-White&Fluffy
//
//  Created by Михаил Зайцев on 07.06.2022.
//

import UIKit

final class FavouritesPhotosCollectionVC: UIViewController {
    
    var photos = [UnsplashPhoto]()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(FavouritesPhotosCell.self, forCellWithReuseIdentifier: FavouritesPhotosCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        return collectionView
    }()

    private let enterSearchTermLabel: UILabel = {
        let label = UILabel()
        label.text = "Featured photos will be displayed here"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        configView()
    }

// MARK: - Private Metods
    private func configView() {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.addSubview(enterSearchTermLabel)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            enterSearchTermLabel.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 50),
            enterSearchTermLabel.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor, constant: 16),
            enterSearchTermLabel.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor, constant: -16)
        ])
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Favourites"
    }
}

// MARK: - UICollecionViewDataSource, UICollecionViewDelegate
extension FavouritesPhotosCollectionVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        enterSearchTermLabel.isHidden = photos.count != 0
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavouritesPhotosCell.identifier, for: indexPath) as! FavouritesPhotosCell
        let unsplashPhoto = photos[indexPath.item]
        cell.unsplashPhoto = unsplashPhoto
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FavouritesPhotosCollectionVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width/3 - 1, height: width/3 - 1)
    }
}
