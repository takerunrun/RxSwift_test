//
//  ViewController.swift
//  RxSample
//
//  Created by admin on 2018/07/02.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let mainView = MainView()
    
//    let viewControllers: [UIViewController] = {
//        let viewControllers: [UIViewController] = [NumberViewController(), SimpleValidationViewController(), SimpleTableViewExapmleViewController(), SectionedTableViewExampleViewController(), VoiceViewController(), EdittingTableViewController(), ImagePickerController()]
//        return viewControllers
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setView()
        setFun()
        
        
    }

    func setView() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.mainView)
        self.mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setFun() {
        for button in self.mainView.buttons {
            button.addTarget(self, action: #selector(onTappedButton(_:)), for: .touchUpInside)
        }
    }
    
    @objc func onTappedButton(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            self.navigationController?.pushViewController(NumberViewController(), animated: true)
        case 1:
            self.navigationController?.pushViewController(SimpleValidationViewController(), animated: true)
        case 2:
            self.navigationController?.pushViewController(SimpleTableViewExapmleViewController(), animated: true)
        case 3:
            self.navigationController?.pushViewController(SectionedTableViewExampleViewController(), animated: true)
        case 4:
            self.navigationController?.pushViewController(VoiceViewController(), animated: true)
        case 5:
            self.navigationController?.pushViewController(EdittingTableViewController(), animated: true)
        case 6:
            self.navigationController?.pushViewController(ImagePickerController(), animated: true)
        case 7:
            self.navigationController?.pushViewController(GreetingViewController(), animated: true)
        case 8:
            self.navigationController?.pushViewController(ArtListController(), animated: true)
        case 9:
            self.navigationController?.pushViewController(RepositoryListController(), animated: true)
        case 10:
            self.navigationController?.pushViewController(PageControlViewController(), animated: true)
        default:
            print("default")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

