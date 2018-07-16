//
//  SimpleValidationViewController.swift
//  RxSample
//
//  Created by admin on 2018/07/02.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SimpleValidationViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    let minimalUsernameLength = 5
    let minimalPasswordLength = 8
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "UserName"
        return label
    }()
    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "what's your name?"
        return textField
    }()
    let usernameValidateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        return label
    }()
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "PassWord"
        return label
    }()
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "what's your password?"
        return textField
    }()
    let passwordValidateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("touch me!", for: .normal)
        button.backgroundColor = .green
        button.setTitle("pushed", for: .highlighted)
        button.setTitle("enable", for: .disabled)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setV()
        setValid()
    }
    
    func setValid() {
        let usernameValid = self.usernameTextField.rx.text.orEmpty
            .map{ $0.count >= self.minimalUsernameLength }
            .share(replay: 1)
        
        let passwordValid = self.passwordTextField.rx.text.orEmpty
            .map{ $0.count >= self.minimalPasswordLength }
            .share(replay: 1)
        
        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .share(replay: 1)
        
        usernameValid
            .bind(to: self.passwordTextField.rx.isEnabled)
            .disposed(by: disposeBag)
        
        usernameValid
            .bind(to: self.usernameValidateLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        passwordValid
            .bind(to: self.passwordValidateLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        everythingValid
            .bind(to: self.button.rx.isEnabled)
            .disposed(by: disposeBag)
        
        self.button.rx.tap
            .subscribe(onNext: { [weak self] _ in self?.showAlert()})
            .disposed(by: disposeBag)
    }
    
    func showAlert() {
        let alertView = UIAlertView(title: "Alert", message: "Nothing Happen!!", delegate: nil, cancelButtonTitle: "OK")
        
        alertView.show()
    }
    
    func setV() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.usernameLabel)
        self.view.addSubview(self.usernameTextField)
        
        self.usernameValidateLabel.text = "Username has to be at least \(self.minimalUsernameLength) characters"
        self.view.addSubview(self.usernameValidateLabel)
        self.view.addSubview(self.passwordLabel)
        self.view.addSubview(self.passwordTextField)
        self.passwordValidateLabel.text = "Password has to be at leadt \(self.minimalPasswordLength) characters"
        self.view.addSubview(self.passwordValidateLabel)
        self.view.addSubview(self.button)
        
        self.usernameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview().offset(20)
        }
        self.usernameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self.usernameLabel.snp.bottom).offset(10)
            make.left.equalTo(self.usernameLabel)
            make.height.equalTo(30)
            make.width.equalTo(200)
        }
        self.usernameValidateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.usernameTextField.snp.bottom).offset(10)
            make.left.equalTo(self.usernameLabel)
        }
        self.passwordLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.usernameValidateLabel.snp.bottom).offset(20)
            make.left.equalTo(self.usernameLabel)
        }
        self.passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self.passwordLabel.snp.bottom).offset(10)
            make.left.equalTo(self.usernameLabel)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        self.passwordValidateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.passwordTextField.snp.bottom).offset(10)
            make.left.equalTo(self.usernameLabel)
        }
        self.button.snp.makeConstraints { (make) in
            make.top.equalTo(self.passwordValidateLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(40)
        }
    }
}
