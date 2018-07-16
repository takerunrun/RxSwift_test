//
//  NumberCell.swift
//  RxSample
//
//  Created by admin on 2018/07/07.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit

class NumberCell: UICollectionViewCell {
    let valueLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.valueLabel)
        self.valueLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
