//
//  EdittingTableViewCell.swift
//  RxSample
//
//  Created by admin on 2018/07/07.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit

class EdittingTableViewCell: UITableViewCell {
    let itemNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    let label: UILabel = {
        let label = UILabel()
        label.text = "text"
        return label
    }()
    
    var item: App! {
        didSet {
            itemNameLabel.text = item.name
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.itemNameLabel)
        self.contentView.addSubview(self.label)
        self.itemNameLabel.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.left.equalTo(self.label.snp.right).offset(10)
        }
        self.label.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(100)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
