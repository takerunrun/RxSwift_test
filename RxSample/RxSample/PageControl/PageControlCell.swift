//
//  PageControlCell.swift
//  RxSample
//
//  Created by admin on 2018/07/09.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit

class PageControlCell: UICollectionViewCell {
    
    let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .orange
        
        self.contentView.addSubview(self.cellImageView)
        self.cellImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
