//
//  RatingTableViewCell.swift
//  RSSchool_T10
//
//  Created by Vitaly Nabarouski on 8/30/21.
//

import UIKit

class RatingTableViewCell: UITableViewCell {

    func configure(place: Int, name: String, score: Int16) {
        self.selectionStyle = .none
        self.backgroundColor = UIColor(red: 35 / 255, green: 35 / 255, blue: 35 / 255, alpha: 1)
        
        let placeLabel = UILabel()
        placeLabel.textColor = .white
        placeLabel.font = UIFont(name: "Nunito-ExtraBold", size: 28)
        placeLabel.text = "#\(place + 1)"
        contentView.addSubview(placeLabel)
        placeLabel.translatesAutoresizingMaskIntoConstraints = false
        placeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        placeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2).isActive = true
        placeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2).isActive = true
        placeLabel.contentHuggingPriority(for: .horizontal)
        
        let textLabel = UILabel()
        textLabel.text = name
        textLabel.textColor = UIColor(red: 0.922, green: 0.682, blue: 0.408, alpha: 1)
        textLabel.font = UIFont(name: "Nunito-ExtraBold", size: 28)
        textLabel.adjustsFontSizeToFitWidth = true
        contentView.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        textLabel.leadingAnchor.constraint(equalTo: placeLabel.trailingAnchor, constant: 10).isActive = true
        
        let pointLabel = UILabel()
        pointLabel.textColor = .white
        pointLabel.font = UIFont(name: "Nunito-ExtraBold", size: 28)
        pointLabel.text = String(score)
        contentView.addSubview(pointLabel)
        pointLabel.translatesAutoresizingMaskIntoConstraints = false
        pointLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        pointLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        pointLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        self.prepareForReuse()
    }
    
}
