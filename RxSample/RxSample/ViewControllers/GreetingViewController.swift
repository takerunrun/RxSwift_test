//
//  GreetingViewController.swift
//  RxSample
//
//  Created by admin on 2018/07/08.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class GreetingViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    enum State: Int {
        case useButtons = 0
        case useTextField = 1
    }
    
    let greetingLable: UILabel = {
        let label = UILabel()
        return label
    }()
    let stateSegmentedControl: UISegmentedControl = {
        let items: [String] = ["select how to start", "free writing"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    let freeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "free TextField"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always
        textField.returnKeyType = .done
        return textField
    }()
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "name TextField"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let lastSelectedGreeting: Variable<String> = Variable("こんにちは")
    
    var greetingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    let greetingButtons: [UIButton] = {
        var buttons: [UIButton] = []
        let greetings: [String] = ["Hello", "Good morning", "Good evening", "Hi!!!"]
        for greet in greetings {
            let button = CustomButton()
            button.set(title: greet, font: .boldSystemFont(ofSize: 15), cornerRadius: 0)
            button.setTextColor(normalColor: .blue, highlitedColor: .gray)
            button.setBackColor(normalColor: .white, highlightedColor: .white)
            button.setDisabled(textColor: .orange, backColor: .white)
            buttons.append(button)
        }
        return buttons
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setLogic()
    }
    
    func setView() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.greetingLable)
        self.view.addSubview(self.stateSegmentedControl)
        
        for button in self.greetingButtons {
            self.greetingStackView.addArrangedSubview(button)
        }
        self.view.addSubview(self.greetingStackView)
        
        self.view.addSubview(self.freeTextField)
        self.view.addSubview(self.nameTextField)
        
        self.greetingLable.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview().offset(50)
        }
        self.stateSegmentedControl.snp.makeConstraints { (make) in
            make.top.equalTo(self.greetingLable.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        self.greetingStackView.snp.makeConstraints { (make) in
            make.top.equalTo(self.stateSegmentedControl.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(50)
        }
        self.freeTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self.greetingStackView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
        }
        self.nameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self.freeTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
        }
    }
    
    func setLogic() {
        let nameObservable: Observable<String?> = self.nameTextField.rx.text.asObservable()
        let freeObservable: Observable<String?> = self.freeTextField.rx.text.asObservable()
        let freewordWithNameObservable: Observable<String?> = Observable.combineLatest(nameObservable, freeObservable) {
            (string1: String?, string2: String?) in
            return string1! + string2!
        }
        freewordWithNameObservable.bind(to: self.greetingLable.rx.text).disposed(by: disposeBag)
        
        let segmentControlObservable: Observable<Int> = self.stateSegmentedControl.rx.value.asObservable()
        let stateObservable: Observable<State> = segmentControlObservable.map{
            (selectedIndex: Int) -> State in
            return State(rawValue: selectedIndex)!
        }
        let greetingTextFieldEnabledObservable: Observable<Bool> = stateObservable.map{
            (state: State) -> Bool in
            return state == .useTextField
        }
        greetingTextFieldEnabledObservable.bind(to: self.freeTextField.rx.isEnabled).disposed(by: disposeBag)
        
        let buttonsEnabledObservable: Observable<Bool> = greetingTextFieldEnabledObservable.map {
            (greetingEnabled: Bool) -> Bool in
            return !greetingEnabled
        }
        
        self.greetingButtons.forEach { button in
            buttonsEnabledObservable.bind(to: button.rx.isEnabled).disposed(by: disposeBag)
            button.rx.tap.subscribe(onNext: { (nothing: Void) in
                self.lastSelectedGreeting.value = button.currentTitle!
            }).disposed(by: disposeBag)
        }
        
        let predefinedGreetingObservable: Observable<String> = lastSelectedGreeting.asObservable()
        
        let finalGreetingObservable: Observable<String> = Observable.combineLatest(stateObservable, freeObservable, predefinedGreetingObservable, nameObservable) { (state: State, freeword: String?, predefinedGreeting: String, name: String?) -> String in
            switch state {
            case .useTextField: return freeword! + name!
            case .useButtons: return predefinedGreeting + name!
            }
        }
        
        finalGreetingObservable.bind(to: self.greetingLable.rx.text).disposed(by: disposeBag)
        
    }
}
