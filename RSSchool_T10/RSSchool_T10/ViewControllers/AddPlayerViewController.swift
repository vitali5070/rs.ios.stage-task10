//
//  AddPlayerViewController.swift
//  RSSchool_T10
//
//  Created by Vitaly Nabarouski on 8/25/21.
//

import UIKit
import CoreData

class AddPlayerViewController: UIViewController, UITextFieldDelegate {

    var backButton: UIButton?
    var saveButton: UIButton?
    var mainTitleLabel: UILabel?
    var addNewPlayerTextField: CustomTextField?
    var newPlayerClosure: ((String) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 35 / 255, green: 35 / 255, blue: 35 / 255, alpha: 1)
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        addNewPlayerTextField?.becomeFirstResponder()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    private func configureView() {
        setupBackButton()
        setupSaveButton()
        setupMainTitle()
        setupTextField()
    }
    
    private func setupBackButton() {
        backButton = UIButton()
        guard let backButton = backButton else {return}
        backButton.backgroundColor = .clear
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(UIColor(red: 0.518, green: 0.722, blue: 0.678, alpha: 1), for: .normal)
        backButton.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 17)

        self.view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        backButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 41).isActive = true
        
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
    }
    
    private func setupSaveButton() {
        saveButton = UIButton()
        guard let saveButton = saveButton else {return}
        saveButton.setTitle("Add", for: .normal)
        saveButton.setTitleColor(UIColor(red: 0.518, green: 0.722, blue: 0.678, alpha: 1), for: .normal)
        saveButton.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 17)
        
        self.view.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 41).isActive = true
        
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
    }
    
    private func setupMainTitle() {
        mainTitleLabel = UILabel()
        guard let mainTitleLabel = mainTitleLabel else {return}
        mainTitleLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        mainTitleLabel.font = UIFont(name: "Nunito-ExtraBold", size: 36)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.83
        mainTitleLabel.attributedText = NSMutableAttributedString(string: "Add Player", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        self.view.addSubview(mainTitleLabel)
        mainTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        guard let backButton = backButton else {return}
        mainTitleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 12).isActive = true
        mainTitleLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        mainTitleLabel.heightAnchor.constraint(equalToConstant: 41).isActive = true
    }
    
    private func setupTextField() {
        addNewPlayerTextField = CustomTextField()
        guard let addNewPlayerTextField = addNewPlayerTextField else {return}
        addNewPlayerTextField.backgroundColor = UIColor(red: 59 / 255, green: 59 / 255, blue: 59 / 255, alpha: 1)
        addNewPlayerTextField.attributedPlaceholder = NSAttributedString(string: "Player Name",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 155 / 255, green: 155 / 255, blue: 161 / 255, alpha: 1)])
        addNewPlayerTextField.textColor = UIColor(red: 155 / 255, green: 155 / 255, blue: 161 / 255, alpha: 1)
        addNewPlayerTextField.font = UIFont(name: "Nunito-ExtraBold", size: 20)
        addNewPlayerTextField.borderStyle = .line
        addNewPlayerTextField.delegate = self
        
        self.view.addSubview(addNewPlayerTextField)
        addNewPlayerTextField.translatesAutoresizingMaskIntoConstraints = false
        guard let mainTitleLabel = mainTitleLabel else {return}
        addNewPlayerTextField.topAnchor.constraint(equalTo: mainTitleLabel.bottomAnchor, constant: 25).isActive = true
        addNewPlayerTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        addNewPlayerTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        addNewPlayerTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        addNewPlayerTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
    }
    
    @objc func backTapped() {
        dismiss(animated: true)
    }
    
    @objc func saveTapped() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Players", in: context)
        guard let entityU = entity else {return}
        let nameObject = NSManagedObject(entity: entityU, insertInto: context) as! Players
        nameObject.name = addNewPlayerTextField?.text
        do {
            try context.save()
            let mainVC = NewGameViewController()
            mainVC.playersArray.append(nameObject)
        } catch {
            print(error.localizedDescription)
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc func textFieldDidChange() {
        if addNewPlayerTextField?.text == ""{
            saveButton?.isHidden = true
        } else {
            saveButton?.isHidden = false
        }
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == ""{
            saveButton?.isHidden = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveTapped()
        return true
    }


}

class CustomTextField: UITextField {
    var textPadding = UIEdgeInsets(
            top: 18,
            left: 24,
            bottom: 18,
            right: 0
        )
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
            let rect = super.textRect(forBounds: bounds)
            return rect.inset(by: textPadding)
        }

        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            let rect = super.editingRect(forBounds: bounds)
            return rect.inset(by: textPadding)
        }
}
