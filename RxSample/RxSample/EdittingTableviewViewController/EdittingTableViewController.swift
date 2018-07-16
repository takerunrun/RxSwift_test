//
//  EdittingTableViewController.swift
//  RxSample
//
//  Created by admin on 2018/07/07.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift
import RxCocoa

class EdittingTableViewController: UIViewController {
    
    var tableView: UITableView = {
        var tableView = UITableView()
        tableView.rowHeight = 40
        return tableView
    }()
    let addButton: CustomButton = {
        let button = CustomButton()
        button.set(title: "add an item", font: UIFont.boldSystemFont(ofSize: 20), cornerRadius: 5)
        button.setTextColor(normalColor: .white, highlitedColor: .white)
        button.setBackColor(normalColor: .orange, highlightedColor: .gray)
        return button
    }()
    let addItemsButton: CustomButton = {
        let button = CustomButton()
        button.set(title: "add items", font: UIFont.boldSystemFont(ofSize: 20), cornerRadius: 5)
        button.setTextColor(normalColor: .white, highlitedColor: .white)
        button.setBackColor(normalColor: .orange, highlightedColor: .gray)
        return button
    }()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(EdittingTableViewCell.self, forCellReuseIdentifier: "cell")
        
        setView()
        bindTableViewDataSource()
        
    }
    
    func setView() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.addButton)
        self.view.addSubview(self.addItemsButton)
        self.view.addSubview(self.tableView)
        
        self.addButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(50)
        }
        self.addItemsButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.addButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(50)
        }
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.addItemsButton.snp.bottom)
            make.right.left.bottom.equalToSuperview()
        }
    }
    
    private func bindTableViewDataSource() {
        let dataSource = RxTableViewSectionedAnimatedDataSource<NumberSection>(configureCell: { (dataSource, tableView, indexPath, item) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EdittingTableViewCell
            
            cell.item = item
            
            return cell
        })
        
        let sections: [NumberSection] = [
            NumberSection(header: "Section 1", apps: [], id: 1)
        ]
        
        let initialState = SectionedTableViewState(sections: sections)
        let addCommand = addButton.rx.tap.asDriver()
            .map { _ -> TableViewEdittingCommand in
                let number = arc4random_uniform(UInt32(Int(100)))
                let item = App(id: Int(number), name: "Atte")
                return TableViewEdittingCommand.AppendItem(item: item, section: 0)
        }
        
        let deleteCommand = tableView.rx.itemDeleted.asDriver()
            .map { indexPath -> TableViewEdittingCommand in
                return TableViewEdittingCommand.DeleteItem(indexPath as NSIndexPath)
        }
        
        let addItemsCommand = addItemsButton.rx.tap.asDriver()
            .map { _ -> TableViewEdittingCommand in
                let items = [
                    App(id: 1, name: "Apple"),
                    App(id: 2, name: "Mercari"),
                    App(id: 3, name: "instagram"),
                    App(id: 4, name: "Facebook"),
                    App(id: 5, name: "Twitter"),
                    App(id: 6, name: "LINE"),
                    App(id: 7, name: "Google Map"),
                    ]
                
                return TableViewEdittingCommand.AppendItems(items: items, section: 0)
        }
        
        let updatedState = Driver
            .of(addCommand, deleteCommand, addItemsCommand)
            .merge()
            .scan(initialState) {
                return $0.executeCommand(command: $1)
            }
            .startWith(initialState)
            .map { $0.sections }
        
        updatedState
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        dataSource.animationConfiguration = AnimationConfiguration(insertAnimation: .none, reloadAnimation: .none, deleteAnimation: .left)
        
//        dataSource.configureCell = { (dataSource, tableView, indexPath, item) in
//            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! EdittingTableViewCell
//
//            cell.item = item
//
//            return cell
//        }
        
        dataSource.titleForHeaderInSection = { (dataSource, section) -> String in
//            return dataSource.sectionAtIndex(section).header
            print(type(of: dataSource[section]))
            print(dataSource[section].header)
            return dataSource[section].header
            
        }
        
        dataSource.canEditRowAtIndexPath = { _,_  in
            return true
        }
    }
}
