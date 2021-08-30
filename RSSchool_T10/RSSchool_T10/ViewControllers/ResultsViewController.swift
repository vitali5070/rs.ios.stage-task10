//
//  ResultsViewController.swift
//  RSSchool_T10
//
//  Created by Vitaly Nabarouski on 8/26/21.
//

import UIKit
import CoreData

class ResultsViewController: UIViewController {
    
    
    var playersArray: [Players] = []
    var progressNameArray: [String] = []
    var progressScoreArray: [String] = []
    var reversedScoreArray: [String] = []
    var reversedNameArray: [String] = []
    var timerHandle: (() -> ())?
    
    var newGameButton: UIButton?
    var resumeButton: UIButton?
    var mainTitleLabel: UILabel?
    let tableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 35 / 255, green: 35 / 255, blue: 35 / 255, alpha: 1)
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        
        
        guard let turns = playersArray.first?.turns else {return}
        progressScoreArray = turns
        guard let name = playersArray.first?.turnsName else {return}
        progressNameArray = name
        
        reversedScoreArray = Array(progressScoreArray.reversed())
        reversedNameArray = Array(progressNameArray.reversed())
        tableView.reloadData()
        self.view.layoutIfNeeded()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.reloadData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    private func configureView() {
        setupNewGameButton()
        setupResultsButton()
        setupMainTitle()
        setupTableView()
    }
    
    private func setupNewGameButton() {
        newGameButton = UIButton()
        guard let newGameButton = newGameButton else {return}
        newGameButton.setTitle("New Game", for: .normal)
        newGameButton.setTitleColor(UIColor(red: 0.518, green: 0.722, blue: 0.678, alpha: 1), for: .normal)
        newGameButton.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 17)
        
        self.view.addSubview(newGameButton)
        newGameButton.translatesAutoresizingMaskIntoConstraints = false
        newGameButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        newGameButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        newGameButton.heightAnchor.constraint(equalToConstant: 41).isActive = true
        
        newGameButton.addTarget(self, action: #selector(newGameButtonTapped), for: .touchUpInside)
    }
    
    private func setupResultsButton() {
        resumeButton = UIButton()
        guard let resultsButton = resumeButton else {return}
        resultsButton.setTitle("Resume", for: .normal)
        resultsButton.setTitleColor(UIColor(red: 0.518, green: 0.722, blue: 0.678, alpha: 1), for: .normal)
        resultsButton.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 17)
        
        self.view.addSubview(resultsButton)
        resultsButton.translatesAutoresizingMaskIntoConstraints = false
        resultsButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        resultsButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        resultsButton.heightAnchor.constraint(equalToConstant: 41).isActive = true
        
        resultsButton.addTarget(self, action: #selector(resumeButtonTapped), for: .touchUpInside)
    }
    
    private func setupMainTitle() {
        mainTitleLabel = UILabel()
        guard let mainTitleLabel = mainTitleLabel else {return}
        mainTitleLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        mainTitleLabel.font = UIFont(name: "Nunito-ExtraBold", size: 36)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.83
        mainTitleLabel.attributedText = NSMutableAttributedString(string: "Results", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        self.view.addSubview(mainTitleLabel)
        mainTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        guard let backButton = newGameButton else {return}
        mainTitleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 12).isActive = true
        mainTitleLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        mainTitleLabel.heightAnchor.constraint(equalToConstant: 41).isActive = true
    }
    
    private func setupTableView(){
        self.view.addSubview(tableView)
        tableView.register(RatingTableViewCell.self, forCellReuseIdentifier: "RatingCell")
        tableView.register(LastTurnTableViewCell.self, forCellReuseIdentifier: "LastTurnCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        guard let mainTitleLabel = mainTitleLabel else {return}
        tableView.topAnchor.constraint(equalTo: mainTitleLabel.bottomAnchor, constant: 20).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
        tableView.backgroundColor = view.backgroundColor
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func headerView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(red: 59 / 255, green: 59 / 255, blue: 59 / 255, alpha: 1)
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        let title = UILabel()
        title.text = "Turns"
        title.textColor = UIColor(red: 0.922, green: 0.922, blue: 0.961, alpha: 0.6)
        title.font = UIFont(name: "Nunito-SemiBold", size: 16)
        view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        return view
    }
    
    private func footerView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(red: 59 / 255, green: 59 / 255, blue: 59 / 255, alpha: 1)
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }
    
    @objc func newGameButtonTapped() {
        let newGameVC = NewGameViewController()
        newGameVC.cancelButton.isHidden = false
        newGameVC.gameStarted = true
        newGameVC.timerHandle = nil
        self.present(newGameVC, animated: true, completion: nil)
    }
    
    @objc func resumeButtonTapped() {
        dismiss(animated: true) {
            self.timerHandle?()
        }
    }
    
}

extension ResultsViewController:  UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return playersArray.count
        default:
            if progressNameArray.count == progressScoreArray.count {
                return progressNameArray.count
            } else {
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let sortedPlayersArray = playersArray.sorted { $0.score > $1.score }
            let player = sortedPlayersArray[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "RatingCell", for: indexPath) as! RatingTableViewCell
            guard let name = player.name else {return cell}
            cell.configure(place: indexPath.row, name: name, score: player.score)
            return cell
        default:
            
            let score = reversedScoreArray[indexPath.row]
            let name = reversedNameArray[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "LastTurnCell", for: indexPath) as! LastTurnTableViewCell
            cell.configure(name: name, score: score)
            cell.prepareForReuse()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            return headerView()
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            if progressNameArray.count == 0{
                return 0
            } else {
                return 40
            }
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 1 {
            return footerView()
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            if progressNameArray.count == 0{
                return 0
            } else {
                return 40
            }
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}


