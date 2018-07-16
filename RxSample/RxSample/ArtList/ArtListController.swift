//
//  ArtListController.swift
//  RxSample
//
//  Created by admin on 2018/07/08.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ArtListController: UIViewController {
    let disposeBag = DisposeBag()
    
    let ArtsData = ArtPresenter()
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Art>>(
        configureCell: {
            (_, tableView, indexPath, arts) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ArtTableViewCell
//            cell.textLabel?.text = arts.name
//            cell.detailTextLabel?.text = arts.taste
//            cell.imageView?.image = arts.image
            cell.set(image: arts.image!, name: arts.name, taste: arts.taste)
            print(indexPath.section)
            return cell
        },
        titleForHeaderInSection: { (ds, section: Int) -> String in
            return ds[section].model
        }
    )
    
    let artTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 65
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        
        self.ArtsData.arts.bind(to: artTableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        self.artTableView.rx.setDelegate(self).disposed(by: disposeBag)
        self.artTableView.register(ArtTableViewCell.self, forCellReuseIdentifier: "Cell")

    }
    
    func setView() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.artTableView)
        self.artTableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(64)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

extension ArtListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(65)
    }
}
