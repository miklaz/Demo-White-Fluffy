//
//  PhotosCollectionVC.swift
//  Demo-White&Fluffy
//
//  Created by Михаил Зайцев on 07.06.2022.
//

import UIKit

final class PhotosCollectionVC: UIViewController {
    
    var networkDataFetcher = NetworkDataFetcher()
    private let itemsPerRow: CGFloat = 2
    private let sectionInserts = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    private var timer: Timer?
    private var photos = [UnsplashPhoto]()
    private var selectedImages = [UIImage]()
    
    private var numberOfSelectedPhotos: Int {
        return collectionView.indexPathsForSelectedItems?.count ?? 0
    }

    private lazy var addBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonTapped))
    }()
    
    private lazy var shareBarButtonItem: UIBarButtonItem = {
       return UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareBarButtonTapped))
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PhotosCollectionCell.self, forCellWithReuseIdentifier: PhotosCollectionCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.contentInsetAdjustmentBehavior = .automatic
        collectionView.allowsMultipleSelection = true
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configView()
        configNavigationBar()
        configSearchBar()
    }
}
// MARK: - Private Metods
extension PhotosCollectionVC {
    private func refresh() {
        self.selectedImages.removeAll()
        self.collectionView.selectItem(at: nil, animated: true, scrollPosition: [])
        undateNavButtonsState()
    }
    
    private func configView() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func configNavigationBar() {
        title = "Photos"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        addBarButtonItem.tintColor = .systemOrange
        shareBarButtonItem.tintColor = .systemOrange
        navigationItem.leftBarButtonItem = addBarButtonItem
        navigationItem.rightBarButtonItem = shareBarButtonItem
    }
    
    private func configSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
    private func undateNavButtonsState() {
        addBarButtonItem.isEnabled = numberOfSelectedPhotos > 0
        shareBarButtonItem.isEnabled = numberOfSelectedPhotos > 0
    }

    private func newVC() {
        let photoDetailVC = PhotoDetailVC(PhotoDetailView())
        photoDetailVC.photoView.photoImage.image = UIImage(systemName: "photo")
        photoDetailVC.modalPresentationStyle = .formSheet
        present(photoDetailVC, animated: true, completion: nil)
    }
    
    private func createShareController() {
        let shareController = UIActivityViewController(activityItems: selectedImages, applicationActivities: nil)
        shareController.completionWithItemsHandler = { _, bool, _, _ in
            if bool {
                self.refresh()
            }
        }
        shareController.popoverPresentationController?.permittedArrowDirections = .any
        present(shareController, animated: true, completion: nil)
    }
    
// MARK: - BarButton actions
    @objc private func addBarButtonTapped() {
        print(#function)
        let selectedPhotos = collectionView.indexPathsForSelectedItems?.reduce([], { (photosss, indexPath) -> [UnsplashPhoto] in
            var mutablePhotos = photosss
            let photo = photos[indexPath.item]
            mutablePhotos.append(photo)
            return mutablePhotos
        })
        
        let alertController = UIAlertController(title: "", message: "\(selectedPhotos!.count) photos will added in library", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in }
        let add = UIAlertAction(title: "Add", style: .default) { (action) in
            let tabbar = self.tabBarController as! TabBarController
            let navVC = tabbar.viewControllers?[1] as! UINavigationController
            let Favourites = navVC.topViewController as! FavouritesPhotosCollectionVC
            
            Favourites.photos.append(contentsOf: selectedPhotos ?? [])
            Favourites.collectionView.reloadData()

            self.refresh()
        }
        
        alertController.addAction(cancel)
        alertController.addAction(add)
        present(alertController, animated: true)
    }
    
    @objc private func shareBarButtonTapped() {
        print(#function)
        newVC()
    }
}

// MARK: - UICollecionViewDataSource, UICollecionViewDelegate
extension PhotosCollectionVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionCell.identifier, for: indexPath) as! PhotosCollectionCell
        let unsplashPhoto = photos[indexPath.item]
        cell.unsplashPhoto = unsplashPhoto
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        undateNavButtonsState()
        let cell = collectionView.cellForItem(at: indexPath) as! PhotosCollectionCell
        guard let image = cell.photoImageView.image else { return }
        selectedImages.append(image)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        undateNavButtonsState()
        let cell = collectionView.cellForItem(at: indexPath) as! PhotosCollectionCell
        guard let image = cell.photoImageView.image else { return }
        if let index = selectedImages.firstIndex(of: image) {
            selectedImages.remove(at: index)
        }
    }
}

// MARK: - UISearchBarDelegate
extension PhotosCollectionVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //print(searchText)
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { (_) in
            self.networkDataFetcher.fetchImeages(searchTerm: searchText) { [weak self] (searchResults) in
                guard let fetchedPhotos = searchResults else { return }
                self?.photos = fetchedPhotos.results
                //print(fetchedPhotos)
                self?.collectionView.reloadData()
                self?.refresh()
            }
        })
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PhotosCollectionVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let photo = photos[indexPath.item]
        let paddingSpace = sectionInserts.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let height = CGFloat(photo.height) * widthPerItem / CGFloat(photo.width)
        return CGSize(width: widthPerItem, height: height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sectionInserts
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return sectionInserts.left
    }
}
