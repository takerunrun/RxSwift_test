//
//  RepositoryCell.swift
//  RxSample
//
//  Created by admin on 2018/07/08.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit

class RepositoryCell: UITableViewCell {
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    let urlLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.urlLabel)
        
        self.nameLabel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(10)
        }
        self.urlLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.nameLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
        }
    }
    
    func set(name: String, url: String) {
        self.nameLabel.text = name
        self.urlLabel.text = url
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
