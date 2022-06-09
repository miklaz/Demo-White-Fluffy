//
//  PhotosCollectionCell.swift
//  Demo-White&Fluffy
//
//  Created by Михаил Зайцев on 07.06.2022.
//

import UIKit
import SDWebImage

final class PhotosCollectionCell: UICollectionViewCell {
    
    static let identifier = "PhotosCollectionCell"
    
    private let checkMark: UIImageView = {
        let image = UIImage(systemName: "checkmark.circle.fill")
        let imageView = UIImageView(image: image)
        imageView.alpha = 0
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemBackground
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.systemOrange.cgColor

        return imageView
    }()
    
    var unsplashPhoto: UnsplashPhoto! {
        didSet {
            let photoURL = unsplashPhoto.urls["small"]
            guard let imageURL = photoURL, let url = URL(string: imageURL) else { return }
            photoImageView.sd_setImage(with: url, completed: nil)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            updateSelectedState()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configCell()
        updateSelectedState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Metods
    private func configCell() {
        addSubview(photoImageView)
        photoImageView.addSubview(checkMark)
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: self.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            checkMark.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: -8),
            checkMark.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: -8)
        ])
    }

    private func updateSelectedState() {
        UIView.animate(withDuration: 0.3) {
            self.photoImageView.alpha = self.isSelected ? 0.7 : 1
            self.checkMark.alpha = self.isSelected ? 1 : 0
        }
    }
}
