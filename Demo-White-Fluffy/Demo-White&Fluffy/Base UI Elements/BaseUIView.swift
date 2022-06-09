//
//  BaseUIView.swift
//  Demo-White&Fluffy
//
//  Created by Михаил Зайцев on 07.06.2022.
//

import UIKit

final class BaseUIView: UIView {
    
    init(backgroundColor: UIColor){
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = backgroundColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
