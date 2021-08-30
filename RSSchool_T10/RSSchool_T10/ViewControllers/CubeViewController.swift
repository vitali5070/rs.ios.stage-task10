//
//  CubeViewController.swift
//  RSSchool_T10
//
//  Created by Vitaly Nabarouski on 8/26/21.
//

import UIKit
import CoreData

class CubeViewController: UIViewController {
    
    var cubeImageView: UIImageView?
    let randomNumber = Int.random(in: 1...6)
    let cubeImageArray = ["dice_1","dice_2","dice_3","dice_4","dice_5","dice_6"]
    var timerHandle: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    private func configureView() {
        self.view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        
        cubeImageView = UIImageView()
        guard let cubeIV = cubeImageView else {return}
        let image = UIImage(named: cubeImageArray[randomNumber - 1])
        cubeIV.image = image
        self.view.addSubview(cubeIV)
        cubeIV.translatesAutoresizingMaskIntoConstraints = false
        cubeIV.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        cubeIV.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        cubeIV.heightAnchor.constraint(equalToConstant: 120).isActive = true
        cubeIV.widthAnchor.constraint(equalTo: cubeIV.heightAnchor).isActive = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(back))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func back(){
        dismiss(animated: true) {
            self.timerHandle?()
        }
    }
    
}
