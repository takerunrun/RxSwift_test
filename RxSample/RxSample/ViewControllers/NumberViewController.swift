//
//  NumberViewController.swift
//  RxSample
//
//  Created by admin on 2018/07/02.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit
import SnapKit

class NumberViewController: ViewController {
    
    let textField1: UITextField = {
        let tf = UITextField()
        tf.textAlignment = .center
        tf.layer.borderWidth = 2
        tf.layer.borderColor = UIColor.black.cgColor
        return tf
    }()
    let textField2 = UITextField()
    let textField3 = UITextField()
    
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(textField1)
        self.view.addSubview(textField2)
        self.view.addSubview(textField3)
        
        self.textField1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
    }
}
