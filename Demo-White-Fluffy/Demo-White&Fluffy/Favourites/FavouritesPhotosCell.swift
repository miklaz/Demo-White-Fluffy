//
//  FavouritesPhotosCell.swift
//  Demo-White&Fluffy
//
//  Created by Михаил Зайцев on 07.06.2022.
//

import UIKit
import SDWebImage

final class FavouritesPhotosCell: UICollectionViewCell {

    static let identifier = "FavouritesPhotosCell"

    var myImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 15
        
        return imageView
    }()

    var unsplashPhoto: UnsplashPhoto! {
        didSet {
            let photoUrl = unsplashPhoto.urls["small"]
            guard let imageUrl = photoUrl, let url = URL(string: imageUrl) else { return }
            myImageView.sd_setImage(with: url, completed: nil)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        myImageView.image = nil
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        configCell()
    }

    func configCell() {
        addSubview(myImageView)
        myImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        myImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        myImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        myImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

    func set(photo: UnsplashPhoto) {
        let photoUrl = photo.urls["full"]
        guard let photoURL = photoUrl, let url = URL(string: photoURL) else { return }
        myImageView.sd_setImage(with: url, completed: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}