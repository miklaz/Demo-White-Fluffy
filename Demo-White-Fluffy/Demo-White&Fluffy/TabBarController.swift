//
//  TabBarController.swift
//  FinalProject-Test
//
//  Created by Михаил Зайцев on 07.06.2022.
//

import UIKit

final class TabBarController: UITabBarController{
    
// MARK: - VС Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createTabBar()
        configTabBar()
    }
}

// MARK: - Private Metods
extension TabBarController: UITabBarControllerDelegate {
    private func createTabBar() {
        let photosCollection = BaseNavigationController(rootViewController: PhotosCollectionVC())
        let favouritesPhotosCollection = BaseNavigationController(rootViewController: FavouritesPhotosCollectionVC())
        
        photosCollection.title = "Photos"
        favouritesPhotosCollection.title = "Favourites"

        setViewControllers([photosCollection, favouritesPhotosCollection], animated: true)
        
        let images = ["photo.on.rectangle", "heart"]
        let selectedImages = ["photo.fill.on.rectangle.fill", "heart.fill"]
        guard let items = tabBar.items else { return }
        for i in 0..<items.count{
            items[i].image = UIImage(systemName: images[i])
            items[i].selectedImage = UIImage(systemName: selectedImages[i])
        }
    }
    
    private func configTabBar(){
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground.withAlphaComponent(0.9)
        
        tabBar.standardAppearance = appearance
        setTabBarItemColors(appearance.stackedLayoutAppearance)
        setTabBarItemColors(appearance.inlineLayoutAppearance)
        setTabBarItemColors(appearance.compactInlineLayoutAppearance)
        self.tabBar.standardAppearance = appearance
        
        if #available(iOS 15.0, *) {
            self.tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
    }
    
    private func setTabBarItemColors(_ itemAppearance: UITabBarItemAppearance) {
        itemAppearance.normal.iconColor = .label
        itemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
        itemAppearance.selected.iconColor = .systemOrange
        itemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemOrange]
    }
}

