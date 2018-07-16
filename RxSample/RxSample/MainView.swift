//
//  MainView.swift
//  RxSample
//
//  Created by admin on 2018/07/08.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit

class MainView: UIView {
    
    let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 30
        return stack
    }()
    
    var buttons: [CustomButton] = {
        var buttons: [CustomButton] = []
        
        let names: [String] = ["NumberViewController", "SimpleValidationController", "SimpleTableViewExampleViewController", "SectionedTableViewExampleViewController", "VoiceViewController", "EdittingTableViewController", "ImagePickerController", "GreetingViewController", "ArtListController", "RepositoryListController", "PageContrlViewController"]
        
        for (i, name) in names.enumerated() {
            let button = CustomButton()
            button.tag = i
            button.set(title: name, font: .boldSystemFont(ofSize: 12), cornerRadius: 10)
            button.setTextColor(normalColor: .white, highlitedColor: .white)
            button.setBackColor(normalColor: .orange, highlightedColor: .gray)
            buttons.append(button)
        }
        return buttons
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        for button in self.buttons {
            self.stack.addArrangedSubview(button)
            button.snp.makeConstraints { (make) in
                make.width.equalTo(300)
            }
        }
        
        self.addSubview(self.stack)
        self.stack.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.bottom.equalToSuperview().offset(-20)
        }
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
