//
//  NewGameViewController.swift
//  RSSchool_T10
//
//  Created by Vitaly Nabarouski on 8/25/21.
//

import UIKit
import CoreData

class NewGameViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var heightConstraint: NSLayoutConstraint?
    let heightForHeader = 60
    let heightForFooter = 60
    let heightForRow = 60
    var playersArray: [Players] = []
    var gameStarted: Bool = false
    var timerHandle: (() -> ())?
    
    
    var cancelButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        return button
    }()
    var mainTitleLabel: UILabel?
    var startGameButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.518, green: 0.722, blue: 0.678, alpha: 1)
        button.layer.cornerRadius = 65 / 2
        button.layer.shadowColor = UIColor(red: 84 / 255, green: 120 / 255, blue: 111 / 255, alpha: 1).cgColor
        button.layer.shadowRadius = 0
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = CGSize(width: 0, height: 5)
        
        
        button.setTitle("Start game", for: .normal)
        button.titleLabel?.layer.shadowColor = UIColor(red: 0.329, green: 0.471, blue: 0.435, alpha: 1).cgColor
        button.titleLabel?.layer.shadowRadius = 0
        button.titleLabel?.layer.shadowOpacity = 1
        button.titleLabel?.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.titleLabel?.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        button.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 24)
        return button
    }()
    var tableView: UITableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 35 / 255, green: 35 / 255, blue: 35 / 255, alpha: 1)
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Players> = Players.fetchRequest()
        do {
            playersArray = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
        tableView.reloadData()
        self.view.layoutIfNeeded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if playersArray.count != 0 && gameStarted == false{
            showGameVC()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    private func configureView() {
        setupCancelButton()
        setupMainTitle()
        setupTableView()
        setupStartGameButton()
    }
    
    private func setupCancelButton() {
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(UIColor(red: 0.518, green: 0.722, blue: 0.678, alpha: 1), for: .normal)
        cancelButton.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 17)
        
        self.view.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 41).isActive = true
        
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    
    private func setupMainTitle() {
        mainTitleLabel = UILabel()
        guard let mainTitleLabel = mainTitleLabel else {return}
        mainTitleLabel.text = "Game Counter"
        mainTitleLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        mainTitleLabel.font = UIFont(name: "Nunito-ExtraBold", size: 36)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.83
        mainTitleLabel.attributedText = NSMutableAttributedString(string: "Game Counter", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        self.view.addSubview(mainTitleLabel)
        mainTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        mainTitleLabel.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 12).isActive = true
        mainTitleLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        mainTitleLabel.heightAnchor.constraint(equalToConstant: 41).isActive = true
    }
    
    private func setupStartGameButton() {
        self.view.addSubview(startGameButton)
        
        startGameButton.translatesAutoresizingMaskIntoConstraints = false
        startGameButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -65).isActive = true
        startGameButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        startGameButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        startGameButton.heightAnchor.constraint(equalToConstant: 65).isActive = true
        
        startGameButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        
    }
    
    private func setupTableView() {
        guard let mainTitleLabel = mainTitleLabel else {return}
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "playersCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 15
        tableView.backgroundColor = UIColor(red: 59 / 255, green: 59 / 255, blue: 59 / 255, alpha: 1)
        tableView.separatorColor = UIColor(red: 85 / 255, green: 85 / 255, blue: 85 / 255, alpha: 1)
        tableView.isEditing = true
        self.view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: mainTitleLabel.bottomAnchor, constant: 25).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        self.heightConstraint = tableView.heightAnchor.constraint(equalToConstant: CGFloat(heightForRow * playersArray.count + heightForHeader + heightForFooter))
        guard let heightConstraint = self.heightConstraint else {
            return
        }
        heightConstraint.isActive = true
        
    }
    
    private func footerView() -> UIView {
        let view = UIView()
        view.backgroundColor = tableView.backgroundColor
        let title = UILabel()
        title.text = "Add player"
        title.textColor = UIColor(red: 132 / 255, green: 184 / 255, blue: 173 / 255, alpha: 1)
        title.font = UIFont(name: "Nunito-SemiBold", size: 16)
        view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.topAnchor.constraint(equalTo: view.topAnchor, constant: 14).isActive = true
        title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 56).isActive = true
        
        let addButton = UIButton()
        addButton.backgroundColor = UIColor(red: 132 / 255, green: 184 / 255, blue: 173 / 255, alpha: 1)
        addButton.layer.cornerRadius = 25 / 2
        let plusImage = UIImageView()
        plusImage.image = UIImage(named: "plus")
        addButton.addSubview(plusImage)
        plusImage.translatesAutoresizingMaskIntoConstraints = false
        plusImage.centerXAnchor.constraint(equalTo: addButton.centerXAnchor, constant: 0).isActive = true
        plusImage.centerYAnchor.constraint(equalTo: addButton.centerYAnchor, constant: 0).isActive = true
        plusImage.heightAnchor.constraint(equalToConstant: 9).isActive = true
        plusImage.widthAnchor.constraint(equalTo: plusImage.heightAnchor).isActive = true
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        view.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 14).isActive = true
        addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        addButton.widthAnchor.constraint(equalTo: addButton.heightAnchor).isActive = true
        
        return view
    }
    
    @objc func addButtonTapped() {
        let addPlayerVC = AddPlayerViewController()
        addPlayerVC.modalPresentationStyle = .fullScreen
        self.present(addPlayerVC, animated: true, completion: nil)
    }
    
    @objc func startButtonTapped() {
        if playersArray.count > 0 {
            for player in playersArray{
                player.score = 0
                player.turns = []
                player.turnsName = []
                player.seconds = 0
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                do {
                    try context.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
            showGameVC()
        } else {
            let ac = UIAlertController(title: "Add player", message: "Add at least one player", preferredStyle: .alert)
            let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
            ac.addAction(closeAction)
            self.present(ac, animated: true, completion: nil)
        }
    }
    
    func showGameVC() {
        let gameVC = GameViewController()
        gameVC.modalPresentationStyle = .fullScreen
        gameVC.playersArray = playersArray
        if playersArray.count != 0 {
            guard let scoreArray = playersArray[0].turns else {return}
            guard let nameArray = playersArray[0].turnsName else {return}
            gameVC.progressScoreArray = scoreArray
            gameVC.progressNameArray = nameArray
        }
        self.present(gameVC, animated: true, completion: nil)
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true) {
            // start timer
            self.timerHandle?()
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let heightConstraint = self.heightConstraint else {
            return 0
        }
        heightConstraint.constant = CGFloat(heightForRow * playersArray.count + heightForHeader + heightForFooter)
        self.view.layoutIfNeeded()
        return playersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playersCell", for: indexPath)
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor(red: 59 / 255, green: 59 / 255, blue: 59 / 255, alpha: 1)
        let playerName = playersArray[indexPath.row]
        cell.textLabel?.text = playerName.name
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 20)
        let accesoryView = UIView()
        let image = UIImageView(image: UIImage(named: "icon_Sort"))
        accesoryView.addSubview(image)
        cell.accessoryView = accesoryView
        cell.prepareForReuse()
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let playerToDelete = playersArray[indexPath.row] as? Players, editingStyle == .delete else {return}
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(playerToDelete)
        
        do {
            try context.save()
            playersArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            if playersArray.count < 1 {
                cancelButton.isHidden = true
            }
            self.view.layoutIfNeeded()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        playersArray.swapAt(sourceIndexPath.row, destinationIndexPath.row)

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = tableView.backgroundColor
        let title = UILabel()
        title.text = "Players"
        title.textColor = UIColor(red: 235 / 255, green: 235 / 255, blue: 245 / 255, alpha: 0.6)
        title.font = UIFont(name: "Nunito-SemiBold", size: 16)
        view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        title.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return footerView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(heightForHeader)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(heightForFooter)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(heightForRow)
    }
    
    
    
    
}
