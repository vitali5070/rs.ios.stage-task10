//
//  LastTurnTableViewCell.swift
//  RSSchool_T10
//
//  Created by Vitaly Nabarouski on 8/30/21.
//

import UIKit

class LastTurnTableViewCell: UITableViewCell {

    var accesory = UILabel()
    
    func configure(name: String, score: String) {
        let separatorY = self.frame.size.height;
        let separatorHeight = (1.0 / UIScreen.main.scale);
        let separatorWidth = self.frame.size.width;
        let separatorInset: CGFloat = 15.0;
        let separator = UIImageView(frame: CGRect(x: separatorInset, y: separatorY, width: separatorWidth,height: separatorHeight))
        separator.backgroundColor = UIColor(red: 85 / 255, green: 85 / 255, blue: 85 / 255, alpha: 1)
        self.addSubview(separator)
        
        self.selectionStyle = .none
        
        self.textLabel?.text = name
        self.textLabel?.textColor = .white
        self.textLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 20)
        self.backgroundColor = UIColor(red: 59 / 255, green: 59 / 255, blue: 59 / 255, alpha: 1)
        
        
        accesory.text = score
        accesory.textColor = .white
        accesory.textAlignment = .center
        accesory.font = UIFont(name: "Nunito-ExtraBold", size: 20)
        
        self.addSubview(accesory)
        accesory.translatesAutoresizingMaskIntoConstraints = false
        accesory.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        accesory.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        accesory.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        accesory.contentHuggingPriority(for: .horizontal)
    }

}
