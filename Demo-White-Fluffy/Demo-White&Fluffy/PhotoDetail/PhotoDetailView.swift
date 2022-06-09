//
//  PhotoDetailView.swift
//  Demo-White&Fluffy
//
//  Created by Михаил Зайцев on 08.06.2022.
//

import UIKit

final class PhotoDetailView: UIView {
    
    lazy var idLabel = BaseUILabel(text: "idLabel:",
                                      fontSize: 15,
                                      fontWeight: .bold,
                                      textColor: .label,
                                      cornerRadius: nil)
    
    lazy var idValueLabel = BaseUILabel(text: "vDEvoot6mi8",
                                      fontSize: 15,
                                      fontWeight: .regular,
                                      textColor: .label,
                                      cornerRadius: nil)
    
    lazy var createdAtLabel = BaseUILabel(text: "createdAtLabel:",
                                      fontSize: 15,
                                      fontWeight: .bold,
                                      textColor: .label,
                                      cornerRadius: nil)
    
    lazy var createdAtValueLabel = BaseUILabel(text: "2020-11-16T06:56:10-05:00",
                                      fontSize: 15,
                                      fontWeight: .regular,
                                      textColor: .label,
                                      cornerRadius: nil)
    
    lazy var likesLabel = BaseUILabel(text: "likesLabel:",
                                      fontSize: 15,
                                      fontWeight: .bold,
                                      textColor: .label,
                                      cornerRadius: nil)
    
    lazy var likesValueLabel = BaseUILabel(text: "1555",
                                      fontSize: 15,
                                      fontWeight: .regular,
                                      textColor: .label,
                                      cornerRadius: nil)
    
    lazy var photoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.layer.borderWidth = 4
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.systemOrange.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var view = BaseUIView(backgroundColor: .systemBackground)
    
    init(){
        super.init(frame: .zero)
        configuration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PhotoDetailView {
    func configuration(){
        view.backgroundColor = .systemBackground
        addSubview(view)
        view.addSubview(photoImage)
        view.addSubview(idLabel)
        view.addSubview(idValueLabel)
        view.addSubview(createdAtLabel)
        view.addSubview(createdAtValueLabel)
        view.addSubview(likesLabel)
        view.addSubview(likesValueLabel)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            photoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 74),
            photoImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            photoImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            photoImage.heightAnchor.constraint(equalToConstant: 300),
            
            idLabel.topAnchor.constraint(equalTo: photoImage.bottomAnchor, constant: 16),
            idLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            idValueLabel.topAnchor.constraint(equalTo: idLabel.topAnchor),
            idValueLabel.leadingAnchor.constraint(equalTo: idLabel.trailingAnchor, constant: 8),

            createdAtLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 16),
            createdAtLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            createdAtValueLabel.topAnchor.constraint(equalTo: createdAtLabel.topAnchor),
            createdAtValueLabel.leadingAnchor.constraint(equalTo: createdAtLabel.trailingAnchor, constant: 8),
            
            likesLabel.topAnchor.constraint(equalTo: createdAtLabel.bottomAnchor, constant: 16),
            likesLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            likesValueLabel.topAnchor.constraint(equalTo: likesLabel.topAnchor),
            likesValueLabel.leadingAnchor.constraint(equalTo: likesLabel.trailingAnchor, constant: 8),
        ])
    }
}
