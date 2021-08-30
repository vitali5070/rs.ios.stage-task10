//
//  GameViewController.swift
//  RSSchool_T10
//
//  Created by Vitaly Nabarouski on 8/26/21.
//

import UIKit
import CoreData

class GameViewController: UIViewController {
    
    var playersArray: [Players] = []
    var timer: Timer?
    var time = 0
    var timerStatus: Bool = false
    var currentIndexPath: IndexPath = [0, 0]
    var lastContentOffset: CGFloat = 0
    var isMoveRight: Bool?
    var progressNameArray: [String] = []
    var progressScoreArray: [String] = []
    
    
    var newGameButton: UIButton?
    var resultsButton: UIButton?
    var mainTitleLabel: UILabel?
    var cubeButton: UIButton?
    var timerLabel: UILabel?
    var startPauseButton: UIButton?
    var undoButton: UIButton?
    let pointButton1: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.518, green: 0.722, blue: 0.678, alpha: 1)
        button.setTitle("-10", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.layer.shadowColor = UIColor(red: 0.329, green: 0.471, blue: 0.435, alpha: 1).cgColor
        button.titleLabel?.layer.shadowRadius = 0
        button.titleLabel?.layer.shadowOpacity = 1
        button.titleLabel?.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 25)
        return button
    }()
    let pointButton2: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.518, green: 0.722, blue: 0.678, alpha: 1)
        button.setTitle("-5", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.layer.shadowColor = UIColor(red: 0.329, green: 0.471, blue: 0.435, alpha: 1).cgColor
        button.titleLabel?.layer.shadowRadius = 0
        button.titleLabel?.layer.shadowOpacity = 1
        button.titleLabel?.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 25)
        return button
    }()
    let pointButton3: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.518, green: 0.722, blue: 0.678, alpha: 1)
        button.setTitle("-1", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.layer.shadowColor = UIColor(red: 0.329, green: 0.471, blue: 0.435, alpha: 1).cgColor
        button.titleLabel?.layer.shadowRadius = 0
        button.titleLabel?.layer.shadowOpacity = 1
        button.titleLabel?.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 25)
        return button
    }()
    let pointButton4: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.518, green: 0.722, blue: 0.678, alpha: 1)
        button.setTitle("+5", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.layer.shadowColor = UIColor(red: 0.329, green: 0.471, blue: 0.435, alpha: 1).cgColor
        button.titleLabel?.layer.shadowRadius = 0
        button.titleLabel?.layer.shadowOpacity = 1
        button.titleLabel?.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 25)
        return button
    }()
    let pointButton5: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.518, green: 0.722, blue: 0.678, alpha: 1)
        button.setTitle("+10", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.layer.shadowColor = UIColor(red: 0.329, green: 0.471, blue: 0.435, alpha: 1).cgColor
        button.titleLabel?.layer.shadowRadius = 0
        button.titleLabel?.layer.shadowOpacity = 1
        button.titleLabel?.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 25)
        return button
    }()
    var pointButtonsStack: UIStackView?
    var nameLabelStack: UIStackView?
    var largePointButton: UIButton?
    var previousButton: UIButton?
    var nextButton: UIButton?
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(PlayerCollectionViewCell.self, forCellWithReuseIdentifier: "PlayerCell")
        return cv
    }()
    
    // MARH: - ViewLifeCycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 35 / 255, green: 35 / 255, blue: 35 / 255, alpha: 1)
        time = Int(playersArray[currentIndexPath.row].seconds)
        configureView()
        startPauseButtonTapped()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        collectionView.layoutSubviews()
        self.view.layoutIfNeeded()
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let largePointButton = largePointButton else {return}
        largePointButton.layer.cornerRadius = largePointButton.frame.height / 2
        pointButton1.layer.cornerRadius = pointButton1.frame.height / 2
        pointButton2.layer.cornerRadius = pointButton2.frame.height / 2
        pointButton3.layer.cornerRadius = pointButton3.frame.height / 2
        pointButton4.layer.cornerRadius = pointButton4.frame.height / 2
        pointButton5.layer.cornerRadius = pointButton5.frame.height / 2
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.reloadData()
    }
    
    
    func timeString(time: Int) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    private func configureView() {
        setupNewGameButton()
        setupResultsButton()
        setupMainTitle()
        setupCubeButton()
        setupTimerLabel()
        setupStartPauseButton()
        setupUndoButton()
        setupPointButtonsStack()
        setupLargePointButton()
        setupPreviousButton()
        setupNextButton()
        setupCollectionView()
        setupNameLabelStackView()
    }
    
    
    
    
    @objc func newGameButtonTapped() {
        let newGameVC = NewGameViewController()
        newGameVC.cancelButton.isHidden = false
        newGameVC.gameStarted = true
        newGameVC.timerHandle = {
            self.startPauseButtonTapped()
        }
        if timerStatus{
            startPauseButtonTapped()
        }
        self.present(newGameVC, animated: true, completion: nil)
    }
    
    @objc func resultsButtonTapped() {
        let resultsVC = ResultsViewController()
        resultsVC.modalPresentationStyle = .fullScreen
        resultsVC.playersArray = playersArray
        resultsVC.timerHandle = {
            self.startPauseButtonTapped()
        }
        if timerStatus{
            startPauseButtonTapped()
        }
        self.present(resultsVC, animated: true, completion: nil)
    }
    
    @objc func cubeButtonTapped() {
        let cubeVC = CubeViewController()
        cubeVC.modalPresentationStyle = .overCurrentContext
        cubeVC.timerHandle = {
            self.startPauseButtonTapped()
        }
        if timerStatus {
            startPauseButtonTapped()
        }
        self.present(cubeVC, animated: true, completion: nil)
        let feedback = UIImpactFeedbackGenerator(style: .heavy)
        feedback.impactOccurred()
    }
    
    @objc func startPauseButtonTapped() {
        guard let startPauseButton = startPauseButton else {return}
        guard let timerLabel = timerLabel else {return}
        if timerStatus {
            timer?.invalidate()
            timer = nil
            timerStatus = false
            timerLabel.textColor = UIColor(red: 59 / 255, green: 59 / 255, blue: 59 / 255, alpha: 1)
            startPauseButton.setImage(UIImage(named: "Play"), for: .normal)
        } else {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            timerStatus = true
            timerLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            startPauseButton.setImage(UIImage(named: "Pause"), for: .normal)
        }
        self.view.layoutIfNeeded()
    }
    
    @objc func updateTime() {
        if timerStatus{
            time += 1
            guard let timerLabel = timerLabel else {return}
            timerLabel.text = timeString(time: time)
            for player in playersArray {
                player.seconds = Int16(time)
            }
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let queue = DispatchQueue.global(qos: .background)
            
            queue.async {
                do {
                    try context.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    @objc func nextButtonTapped() {
        if timerStatus == false{
            startPauseButtonTapped()
        }
        if currentIndexPath.row == playersArray.count - 1 {
            currentIndexPath.row = 0
            let currentLabel = self.nameLabelStack?.arrangedSubviews[self.currentIndexPath.row] as? UILabel
            let previousLabel = self.nameLabelStack?.arrangedSubviews[playersArray.count - 1] as? UILabel
            guard let currentLabelU = currentLabel else {return}
            guard let previousLabelU = previousLabel else {return}
                currentLabelU.textColor = .white
                self.collectionView.scrollToItem(at: self.currentIndexPath, at: .centeredHorizontally, animated: true)
                previousLabelU.textColor = UIColor(red: 59 / 255, green: 59 / 255, blue: 59 / 255, alpha: 1)
        } else {
            currentIndexPath.row += 1
            let currentLabel = self.nameLabelStack?.arrangedSubviews[self.currentIndexPath.row] as? UILabel
            let previousLabel = self.nameLabelStack?.arrangedSubviews[self.currentIndexPath.row - 1] as? UILabel
            guard let currentLabelU = currentLabel else {return}
            guard let previousLabelU = previousLabel else {return}
                currentLabelU.textColor = .white
                self.collectionView.scrollToItem(at: self.currentIndexPath, at: .centeredHorizontally, animated: true)
                previousLabelU.textColor = UIColor(red: 59 / 255, green: 59 / 255, blue: 59 / 255, alpha: 1)
        }
    }
    
    @objc func previousButtonTapped() {
        if timerStatus == false{
            startPauseButtonTapped()
        }
        if currentIndexPath.row == 0 {
            currentIndexPath.row = playersArray.count - 1
            let currentLabel = self.nameLabelStack?.arrangedSubviews[self.currentIndexPath.row] as? UILabel
            let previousLabel = self.nameLabelStack?.arrangedSubviews[0] as? UILabel
            guard let currentLabelU = currentLabel else {return}
            guard let previousLabelU = previousLabel else {return}
            currentLabelU.textColor = .white
            collectionView.scrollToItem(at: currentIndexPath, at: .centeredHorizontally, animated: true)
            previousLabelU.textColor = UIColor(red: 59 / 255, green: 59 / 255, blue: 59 / 255, alpha: 1)
        } else {
            currentIndexPath.row -= 1
            let currentLabel = self.nameLabelStack?.arrangedSubviews[self.currentIndexPath.row] as? UILabel
            let previousLabel = self.nameLabelStack?.arrangedSubviews[self.currentIndexPath.row + 1] as? UILabel
            guard let currentLabelU = currentLabel else {return}
            guard let previousLabelU = previousLabel else {return}
            currentLabelU.textColor = .white
            collectionView.scrollToItem(at: currentIndexPath, at: .centeredHorizontally, animated: true)
            previousLabelU.textColor = UIColor(red: 59 / 255, green: 59 / 255, blue: 59 / 255, alpha: 1)
            
        }
        
        if progressNameArray.count != 0 && progressScoreArray.count != 0 {
            let previousPlayer = playersArray[currentIndexPath.row]
            
            let previousPoint = progressScoreArray.last
            var previousPlayerScore = previousPlayer.score
            guard let pointString = previousPoint else {return}
            guard let pointToRemove = Int16(pointString) else {return}
            previousPlayerScore = previousPlayerScore - pointToRemove
            previousPlayer.score = previousPlayerScore
            progressNameArray.removeLast()
            progressScoreArray.removeLast()
           
            for player in playersArray {
                player.turns = progressScoreArray
                player.turnsName = progressNameArray
            }
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let queue = DispatchQueue.global(qos: .utility)
            queue.async {
                do{
                    try context.save()
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            
        }
    }
    
    @objc func undoButtonTapped() {
        if progressNameArray.count != 0 && progressScoreArray.count != 0 {
            previousButtonTapped()
        }
    }
    
    @objc func pointButtonTapped(_ sender: UIButton) {
        let player = playersArray[currentIndexPath.row]
        
        var currentScore = player.score
        guard let pointString = sender.titleLabel?.text else {return}
        let point = Int16(pointString)
        guard let pointU = point else {return}
        currentScore = currentScore + pointU
        player.score = currentScore
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let queue = DispatchQueue.global(qos: .utility)
        
        
        guard let name = player.name else {return}
        
        progressNameArray.append(name)
        progressScoreArray.append(pointString)
    
        for player in playersArray {
            player.turns = progressScoreArray
            player.turnsName = progressNameArray
        }
        queue.sync {
            do{
                try context.save()
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        nextButtonTapped()
    }
    
    
    
}

// MARK: - UICollectionViewDelegate and DataSource

extension GameViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playersArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayerCell", for: indexPath) as! PlayerCollectionViewCell
        let player = playersArray[indexPath.row]
        guard let name = player.name else {return cell}
        cell.configure(name: name, score: player.score)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 1.3, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout,
              let dataSourceCount = collectionView.dataSource?.collectionView(collectionView, numberOfItemsInSection: section),
              dataSourceCount > 0 else {
            return .zero
        }
        
        let cellCount = CGFloat(dataSourceCount)
        let itemSpacing = flowLayout.minimumInteritemSpacing
        let cellWidth = flowLayout.itemSize.width + (itemSpacing * cellCount)
        var insets = flowLayout.sectionInset
        
        let totalCellWidth = (cellWidth * cellCount) - itemSpacing
        let contentWidth = collectionView.frame.size.width - collectionView.contentInset.left - collectionView.contentInset.right
        
        guard totalCellWidth < contentWidth else {
            return insets
        }
        
        let padding = (contentWidth - totalCellWidth) / 6
        insets.left = padding
        insets.right = padding
        return insets
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if lastContentOffset < scrollView.contentOffset.x {
            isMoveRight = true
            lastContentOffset = scrollView.contentOffset.x
        } else {
            isMoveRight = false
            lastContentOffset = scrollView.contentOffset.x
        }
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        lastContentOffset = scrollView.contentOffset.x
        guard let isMoveRight = isMoveRight else {return}
        if isMoveRight{
            nextButtonTapped()
        } else {
            previousButtonTapped()
        }
    }
    
    
    
}
// MARK: - GameViewController private func's

extension GameViewController {
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
        resultsButton = UIButton()
        guard let resultsButton = resultsButton else {return}
        resultsButton.setTitle("Results", for: .normal)
        resultsButton.setTitleColor(UIColor(red: 0.518, green: 0.722, blue: 0.678, alpha: 1), for: .normal)
        resultsButton.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 17)
        
        self.view.addSubview(resultsButton)
        resultsButton.translatesAutoresizingMaskIntoConstraints = false
        resultsButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        resultsButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        resultsButton.heightAnchor.constraint(equalToConstant: 41).isActive = true
        
        resultsButton.addTarget(self, action: #selector(resultsButtonTapped), for: .touchUpInside)
    }
    
    private func setupMainTitle() {
        mainTitleLabel = UILabel()
        guard let mainTitleLabel = mainTitleLabel else {return}
        mainTitleLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        mainTitleLabel.font = UIFont(name: "Nunito-ExtraBold", size: 36)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.83
        mainTitleLabel.attributedText = NSMutableAttributedString(string: "Game", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        self.view.addSubview(mainTitleLabel)
        mainTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        guard let backButton = newGameButton else {return}
        mainTitleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 12).isActive = true
        mainTitleLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        mainTitleLabel.heightAnchor.constraint(equalToConstant: 41).isActive = true
    }
    
    private func setupCubeButton(){
        cubeButton = CubeButton()
        guard let cubeButton = cubeButton else {return}
        self.view.addSubview(cubeButton)
        cubeButton.translatesAutoresizingMaskIntoConstraints = false
        guard let resultsButton = resultsButton else {return}
        cubeButton.topAnchor.constraint(equalTo: resultsButton.bottomAnchor, constant: 14).isActive = true
        cubeButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        cubeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        cubeButton.widthAnchor.constraint(equalTo: cubeButton.heightAnchor).isActive = true
        
        cubeButton.addTarget(self, action: #selector(cubeButtonTapped), for: .touchUpInside)
    }
    
    private func setupTimerLabel() {
        timerLabel = UILabel()
        guard let timerLabel = timerLabel else {return}
        
        timerLabel.text = timeString(time: time)
        timerLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        timerLabel.font = UIFont(name: "Nunito-ExtraBold", size: 28)
        
        self.view.addSubview(timerLabel)
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        guard let mainTitleLabel = mainTitleLabel else {return}
        timerLabel.topAnchor.constraint(equalTo: mainTitleLabel.bottomAnchor, constant: 30).isActive = true
        timerLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        timerLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupStartPauseButton() {
        startPauseButton = UIButton()
        guard let startPauseButton = startPauseButton else {return}
        let pauseImage = UIImage(named: "Pause")
        startPauseButton.setImage(pauseImage, for: .normal)
        
        self.view.addSubview(startPauseButton)
        startPauseButton.translatesAutoresizingMaskIntoConstraints = false
        guard let timerLabel = timerLabel else {return}
        startPauseButton.centerYAnchor.constraint(equalTo: timerLabel.centerYAnchor).isActive = true
        startPauseButton.leadingAnchor.constraint(equalTo: timerLabel.trailingAnchor, constant: 20).isActive = true
        startPauseButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        startPauseButton.addTarget(self, action: #selector(startPauseButtonTapped), for: .touchUpInside)
    }
    
    private func setupUndoButton() {
        undoButton = UndoButton()
        guard let undoButton = undoButton else {return}
        
        self.view.addSubview(undoButton)
        undoButton.translatesAutoresizingMaskIntoConstraints = false
        undoButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true
        undoButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -32).isActive = true
        undoButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        undoButton.widthAnchor.constraint(equalToConstant: 15).isActive = true
        
        undoButton.addTarget(self, action: #selector(undoButtonTapped), for: .touchUpInside)
    }
    
    private func setupPointButtonsStack() {
        pointButtonsStack = UIStackView()
        guard let pointButtonsStack = pointButtonsStack else {return}
        pointButtonsStack.axis = NSLayoutConstraint.Axis.horizontal
        pointButtonsStack.distribution = .fillEqually
        pointButtonsStack.alignment = .center
        pointButtonsStack.spacing = 15.0
        
        pointButtonsStack.addArrangedSubview(pointButton1)
        pointButtonsStack.addArrangedSubview(pointButton2)
        pointButtonsStack.addArrangedSubview(pointButton3)
        pointButtonsStack.addArrangedSubview(pointButton4)
        pointButtonsStack.addArrangedSubview(pointButton5)
        
        pointButton1.translatesAutoresizingMaskIntoConstraints = false
        pointButton1.heightAnchor.constraint(equalTo: pointButton1.widthAnchor).isActive = true
        pointButton2.translatesAutoresizingMaskIntoConstraints = false
        pointButton2.heightAnchor.constraint(equalTo: pointButton2.widthAnchor).isActive = true
        pointButton3.translatesAutoresizingMaskIntoConstraints = false
        pointButton3.heightAnchor.constraint(equalTo: pointButton3.widthAnchor).isActive = true
        pointButton4.translatesAutoresizingMaskIntoConstraints = false
        pointButton4.heightAnchor.constraint(equalTo: pointButton4.widthAnchor).isActive = true
        pointButton5.translatesAutoresizingMaskIntoConstraints = false
        pointButton5.heightAnchor.constraint(equalTo: pointButton5.widthAnchor).isActive = true
        
        self.view.addSubview(pointButtonsStack)
        pointButtonsStack.translatesAutoresizingMaskIntoConstraints = false
        pointButtonsStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 22).isActive = true
        pointButtonsStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -22).isActive = true
        guard let undoButton = undoButton else {return}
        pointButtonsStack.bottomAnchor.constraint(equalTo: undoButton.topAnchor, constant: -22).isActive = true
        pointButtonsStack.heightAnchor.constraint(equalToConstant: (self.view.bounds.width - 104) / 5).isActive = true
        
        pointButton1.addTarget(self, action: #selector(pointButtonTapped(_:)), for: .touchUpInside)
        pointButton2.addTarget(self, action: #selector(pointButtonTapped(_:)), for: .touchUpInside)
        pointButton3.addTarget(self, action: #selector(pointButtonTapped(_:)), for: .touchUpInside)
        pointButton4.addTarget(self, action: #selector(pointButtonTapped(_:)), for: .touchUpInside)
        pointButton5.addTarget(self, action: #selector(pointButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func setupLargePointButton() {
        largePointButton = UIButton()
        guard let largePointButton = largePointButton else {return}
        largePointButton.backgroundColor = UIColor(red: 0.518, green: 0.722, blue: 0.678, alpha: 1)
        largePointButton.setTitle("+1", for: .normal)
        largePointButton.titleLabel?.textAlignment = .center
        largePointButton.titleLabel?.adjustsFontSizeToFitWidth = true
        largePointButton.titleLabel?.layer.shadowColor = UIColor(red: 0.329, green: 0.471, blue: 0.435, alpha: 1).cgColor
        largePointButton.titleLabel?.layer.shadowRadius = 0
        largePointButton.titleLabel?.layer.shadowOpacity = 1
        largePointButton.titleLabel?.layer.shadowOffset = CGSize(width: 0, height: 2)
        largePointButton.setTitleColor(.white, for: .normal)
        largePointButton.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 40)
        self.view.addSubview(largePointButton)
        largePointButton.translatesAutoresizingMaskIntoConstraints = false
        largePointButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        guard let pointButtonsStack = pointButtonsStack else {return}
        largePointButton.bottomAnchor.constraint(equalTo: pointButtonsStack.topAnchor, constant: -15).isActive = true
        largePointButton.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        largePointButton.widthAnchor.constraint(equalTo: largePointButton.heightAnchor).isActive = true
        largePointButton.layer.cornerRadius = largePointButton.frame.height / 2
        
        largePointButton.addTarget(self, action: #selector(pointButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func setupPreviousButton() {
        let image = UIImage(named: "icon_Previous")
        guard let imageU = image else {return}
        previousButton = PreviousNextButtons(image: imageU)
        
        guard let previousButton = previousButton else {return}
        self.view.addSubview(previousButton)
        previousButton.translatesAutoresizingMaskIntoConstraints = false
        previousButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 46).isActive = true
        guard let largePointButton = largePointButton else {return}
        previousButton.centerYAnchor.constraint(equalTo: largePointButton.centerYAnchor).isActive = true
        previousButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        previousButton.addTarget(self, action: #selector(previousButtonTapped), for: .touchUpInside)
    }
    
    private func setupNextButton() {
        let image = UIImage(named: "icon_Previous1")
        guard let imageU = image else {return}
        nextButton = PreviousNextButtons(image: imageU)
        
        guard let nextButton = nextButton else {return}
        self.view.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -46).isActive = true
        guard let largePointButton = largePointButton else {return}
        nextButton.centerYAnchor.constraint(equalTo: largePointButton.centerYAnchor).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    private func setupCollectionView() {
        self.view.addSubview(collectionView)
        collectionView.backgroundColor = self.view.backgroundColor
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        guard let timerLabel = timerLabel else {return}
        collectionView.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 30).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        guard let largePointButton = largePointButton else {return}
        collectionView.bottomAnchor.constraint(equalTo: largePointButton.topAnchor, constant: -15).isActive = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.layoutSubviews()
    }
    
    private func setupNameLabelStackView() {
        nameLabelStack = UIStackView()
        guard let nameLabelStack = nameLabelStack else {return}
        for player in playersArray {
           let firstCharFromName = player.name?.first
            guard let charFromName = firstCharFromName else {return}
            let char: String = String(charFromName)
            let label = UILabel()
            label.text = char
            label.textColor = UIColor(red: 59 / 255, green: 59 / 255, blue: 59 / 255, alpha: 1)
            label.font = UIFont(name: "Nunito-ExtraBold", size: 20)
            nameLabelStack.addArrangedSubview(label)
        }
        nameLabelStack.axis = .horizontal
        nameLabelStack.spacing = 5
        nameLabelStack.distribution = .fillEqually
        nameLabelStack.alignment = .center
        self.view.addSubview(nameLabelStack)
        nameLabelStack.translatesAutoresizingMaskIntoConstraints = false
        guard let undoButton = undoButton else {return}
        nameLabelStack.centerYAnchor.constraint(equalTo: undoButton.centerYAnchor).isActive = true
        nameLabelStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        nameLabelStack.heightAnchor.constraint(equalTo: undoButton.heightAnchor).isActive = true
        
        let firstObjInStack = nameLabelStack.arrangedSubviews[0] as? UILabel
        guard let firstObjInStackU = firstObjInStack else {return}
        firstObjInStackU.textColor = .white
    }
}
