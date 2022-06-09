//
//  PhotoDetailVC.swift
//  Demo-White&Fluffy
//
//  Created by Михаил Зайцев on 08.06.2022.
//

import UIKit

final class PhotoDetailVC: UIViewController  {
    
    var photoView = PhotoDetailView()
    
    init(_ touchCardView: PhotoDetailView) {
        self.photoView = touchCardView
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .systemRed
        view = photoView
        view.isOpaque = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.view.subviews.first?.frame = self.view.frame
    }
}

