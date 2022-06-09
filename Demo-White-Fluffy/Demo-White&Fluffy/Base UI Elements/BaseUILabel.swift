//
//  BaseUILabel.swift
//  Demo-White&Fluffy
//
//  Created by Михаил Зайцев on 07.06.2022.
//

import UIKit

final class BaseUILabel: UILabel {
    
    init(text: String, fontSize: CGFloat, fontWeight: UIFont.Weight, textColor: UIColor?, cornerRadius: CGFloat?){
        super.init(frame: .zero)
        
        self.text = text
        self.textColor = textColor ?? .black
        font = .systemFont(ofSize: fontSize, weight: fontWeight)
        layer.cornerRadius = cornerRadius ?? 0
        textAlignment = .left
        numberOfLines = .zero
        adjustsFontSizeToFitWidth = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
