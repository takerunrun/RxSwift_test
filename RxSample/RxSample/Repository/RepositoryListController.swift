//
//  RepositoryListController.swift
//  RxSample
//
//  Created by admin on 2018/07/08.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ObjectMapper
import RxAlamofire

class RepositoryListController: UIViewController {
    
    let nameSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()
    let repositoryListTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 75
        return tableView
    }()
    let tableViewBottomConstraint: NSLayoutConstraint = {
        let constraint = NSLayoutConstraint()
        return constraint
    }()
    
    let disposeBag = DisposeBag()
    
    var repositoriesViewModel: RepositoriesViewModel!
    
    var rx_searchBarText: Observable<String> {
        return nameSearchBar.rx.text
            .filter { $0 != nil }
            .map{ $0! }
            .filter { $0.count > 0 }
        .debounce(0.5, scheduler: MainScheduler.instance)
        .distinctUntilChanged()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.repositoryListTableView.register(RepositoryCell.self, forCellReuseIdentifier: "RepositoryCell")
        
        setView()
        setupRx()
        setupUI()
    }
    
    func setView() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.nameSearchBar)
        self.view.addSubview(self.repositoryListTableView)
        
        self.nameSearchBar.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(64)
            make.left.right.equalToSuperview()
            make.height.equalTo(60)
        }
        self.repositoryListTableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.nameSearchBar.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func setupRx() {
        self.repositoriesViewModel = RepositoriesViewModel(withNameObservable: self.rx_searchBarText)
        
        self.repositoriesViewModel
            .rx_repositories
            .drive(self.repositoryListTableView.rx.items) { (tableView, i, repository) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: IndexPath(row: i, section: 0)) as! RepositoryCell
                cell.set(name: repository.name, url: repository.html_url)
                return cell
        }
        .disposed(by: disposeBag)
        
        self.repositoriesViewModel
            .rx_repositories
            .drive(onNext: { repositories in
                if repositories.count == 0 {
                    let alert = UIAlertController(title: ":(", message: "No repositories for this user", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    
                    if self.navigationController?.visibleViewController is UIAlertController != true {
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            })
            .disposed(by: disposeBag)
    }
    
    func setupUI() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tableTapped(_:)))
        self.repositoryListTableView.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func tableTapped(_ recognizer: UITapGestureRecognizer) {
        let location = recognizer.location(in: repositoryListTableView)
        let path = repositoryListTableView.indexPathForRow(at: location)
        
        if nameSearchBar.isFirstResponder {
            self.nameSearchBar.resignFirstResponder()
        } else if let path = path {
            repositoryListTableView.selectRow(at: path, animated: true, scrollPosition: .middle)
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        self.tableViewBottomConstraint.constant = keyboardFrame.height
        UIView.animate(withDuration: 0.3, animations: {
            self.view.updateConstraints()
            })
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        self.tableViewBottomConstraint.constant = 0.0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.updateConstraints()
        })
    }
}
