//
//  UndoButton.swift
//  RSSchool_T10
//
//  Created by Vitaly Nabarouski on 8/27/21.
//

import UIKit

class UndoButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        let imageView = UIImageView()
        imageView.image = UIImage(named: "undo")
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
