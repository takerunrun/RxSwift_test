//
//  VoiceViewController.swift
//  RxSample
//
//  Created by admin on 2018/07/06.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class VoiceViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 100
        return tableView
    }()
    let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textColor = .gray
        return textField
    }()
    let sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("send", for: .normal)
        button.setTitle("disable", for: .disabled)
        button.backgroundColor = .orange
        return button
    }()
    
    let disposeBag = DisposeBag()
    let model = VoiceModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(VoiceCell.self, forCellReuseIdentifier: "Cell")
        
        setView()
        setLogic()
    }
    
    func setView() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.textField)
        self.view.addSubview(self.sendButton)
        self.view.addSubview(self.tableView)
        
        self.textField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(150)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        self.sendButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.textField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.sendButton.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func setLogic() {
        // TableViewと要素の配列
        model.items.bind(to: self.tableView.rx.items(cellIdentifier: "Cell", cellType: VoiceCell.self)) { (row, element, cell) in
            cell.item(element)
            }.disposed(by: disposeBag)
        
        // 送信ボタンを押す
        self.sendButton.rx.tap.map{ self.textField.text ?? "" }.bind(to: model.rx_items).disposed(by: disposeBag)
        self.sendButton.rx.tap.subscribe(onNext: { _ in
            self.textField.text = nil
        }).disposed(by: disposeBag)
        
        // text入力された時とボタンの有効
        self.textField.rx.text.map { ($0?.count)! > 0 }.bind(to: self.sendButton.rx.isEnabled).disposed(by: disposeBag)
    }
}
