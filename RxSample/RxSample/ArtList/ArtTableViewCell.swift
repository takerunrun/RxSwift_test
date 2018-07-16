//
//  ArtTableViewCell.swift
//  RxSample
//
//  Created by admin on 2018/07/08.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit

class ArtTableViewCell: UITableViewCell {
    
    let artImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    let tasteLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.artImageView)
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.tasteLabel)
        
        self.artImageView.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(80)
        }
        self.nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(self.artImageView.snp.right).offset(50)
        }
        self.tasteLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-50)
        }
    }
    
    func set(image: UIImage, name: String, taste: String) {
        self.artImageView.image = image
        self.nameLabel.text = name
        self.tasteLabel.text = taste
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
