//
//  BaseNavigationController.swift
//  Demo-White&Fluffy
//
//  Created by Михаил Зайцев on 07.06.2022.
//

import UIKit

final class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.isTranslucent = false
        additionalSetup()
    }
    
    private func additionalSetup() {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.shadowImage = nil
            appearance.shadowColor = .clear
            appearance.titleTextAttributes = [
                .foregroundColor: UIColor.label
            ]
            appearance.largeTitleTextAttributes = [
                .foregroundColor: UIColor.black
            ]
            
            UINavigationBar.appearance().tintColor = .label
            navigationBar.standardAppearance = appearance
            navigationBar.compactAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
    }
}
