//
//  PageControlViewController.swift
//  RxSample
//
//  Created by admin on 2018/07/09.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PageControlViewController: UIViewController {
    
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.backgroundColor = .white
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .blue
        return pageControl
    }()
    var collectionView: UICollectionView!
    let layout: UICollectionViewFlowLayout = {
        let layout = CollectionViewFlowLayoutCenterItem()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
//        layout.sectionInset = UIEdgeInsetsMake(200, 100, 0, 100)
        layout.itemSize = CGSize(width: 320, height: 500)
        return layout
    }()
    let disposeBag = DisposeBag()
    var viewModel = PageControlViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        setView()
        setup()
    }
    
    func setView() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.pageControl)
        self.collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: self.layout)
        self.view.addSubview(self.collectionView)
        
        self.collectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(64)
            make.width.equalTo(320)
            make.right.equalToSuperview()
            make.bottom.equalTo(self.pageControl.snp.top)
        }
        self.pageControl.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    func setup() {
        self.collectionView.register(PageControlCell.self, forCellWithReuseIdentifier: "Cell")
        self.collectionView.isPagingEnabled = true
        let sideInset = (self.view.frame.width - self.layout.itemSize.width) / 2
        self.layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        print(self.view.bounds.width)
        print(self.collectionView.bounds.width)
        
        self.viewModel.getData()
            .filter { [unowned self] (images) -> Bool in
                self.pageControl.numberOfPages = images.count
                return images.count > 0
        }
            .bind(to: collectionView.rx.items(cellIdentifier: "Cell", cellType: PageControlCell.self)) { [unowned self] (row, element, cell) in
                cell.cellImageView.image = element
        }
        .disposed(by: disposeBag)
        
        self.collectionView.rx
            .contentOffset
            .map { contentOffset in
                print(contentOffset)
                return Int(contentOffset.x / self.layout.itemSize.width)
        }
            .subscribe(onNext: { i in
                self.pageControl.currentPage = i
            })
        .disposed(by: disposeBag)
        
    }
}
