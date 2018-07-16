//
//  VoiceCell.swift
//  RxSample
//
//  Created by admin on 2018/07/06.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit

class VoiceCell: UITableViewCell {
    var userLabel: UILabel = {
        let label = UILabel()
        label.textColor = .orange
        return label
    }()
    var messageLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.userLabel)
        self.contentView.addSubview(self.messageLabel)
        
        self.userLabel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(10)
        }
        self.messageLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(self.userLabel.snp.bottom).offset(10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func item(_ newValue: VoiceItem) {
        userLabel.text = newValue.user
        messageLabel.text = newValue.message
    }
}
