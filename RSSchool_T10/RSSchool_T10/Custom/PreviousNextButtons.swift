//
//  PreviousNextButtons.swift
//  RSSchool_T10
//
//  Created by Vitaly Nabarouski on 8/27/21.
//

import UIKit

class PreviousNextButtons: UIButton {

    init(image: UIImage) {
        super.init(frame: .zero)
        let imageView = UIImageView()
        imageView.image = image
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
