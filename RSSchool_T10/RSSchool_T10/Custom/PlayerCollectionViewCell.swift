//
//  PlayerCollectionViewCell.swift
//  RSSchool_T10
//
//  Created by Vitaly Nabarouski on 8/27/21.
//

import UIKit

class PlayerCollectionViewCell: UICollectionViewCell {
    
   
    func configure(name: String, score: Int16) {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = UIColor(red: 59 / 255, green: 59 / 255, blue: 59 / 255, alpha: 1)
        contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        let namelabel = UILabel()
        namelabel.textColor = UIColor(red: 235 / 255, green: 174 / 255, blue: 104 / 255, alpha: 1)
        namelabel.font = UIFont(name: "Nunito-ExtraBold", size: 28)
        namelabel.textAlignment = .center
        namelabel.text = name
        namelabel.adjustsFontSizeToFitWidth = true
        view.addSubview(namelabel)
        namelabel.translatesAutoresizingMaskIntoConstraints = false
        namelabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 24).isActive = true
        namelabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        namelabel.contentHuggingPriority(for: .horizontal)
        namelabel.contentHuggingPriority(for: .vertical)

        
        let scorelabel = UILabel()
        scorelabel.textColor = .white
        if UIScreen.main.bounds.width > 375 {
        scorelabel.font = UIFont(name: "Nunito-ExtraBold", size: 100)
        } else {
            scorelabel.font = UIFont(name: "Nunito-ExtraBold", size: 50)
        }
        scorelabel.text = String(score)
        scorelabel.adjustsFontSizeToFitWidth = true
        view.addSubview(scorelabel)
        scorelabel.translatesAutoresizingMaskIntoConstraints = false
        scorelabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scorelabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
}
