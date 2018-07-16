//
//  ImagePickerController.swift
//  RxSample
//
//  Created by admin on 2018/07/07.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ImagePickerController: UIViewController {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
//    let cameraButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("add", for: .normal)
//        return button
//    }()
    let cameraButton: CustomButton = {
        let button = CustomButton()
        button.set(title: "camera", font: .boldSystemFont(ofSize: 20), cornerRadius: 5)
        button.setTextColor(normalColor: .white, highlitedColor: .white)
        button.setBackColor(normalColor: .orange, highlightedColor: .gray)
        return button
    }()
    let galleryButton: CustomButton = {
        let button = CustomButton()
        button.set(title: "gallery", font: .boldSystemFont(ofSize: 20), cornerRadius: 5)
        button.setTextColor(normalColor: .white, highlitedColor: .white)
        button.setBackColor(normalColor: .orange, highlightedColor: .gray)
        return button
    }()
    let cropButton: CustomButton = {
        let button = CustomButton()
        button.set(title: "crop", font: .boldSystemFont(ofSize: 20), cornerRadius: 5)
        button.setTextColor(normalColor: .white, highlitedColor: .white)
        button.setBackColor(normalColor: .orange, highlightedColor: .gray)
        return button
    }()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        set()
        setLogic()
    }
    
    func set() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.imageView)
        self.view.addSubview(self.cameraButton)
        self.view.addSubview(self.galleryButton)
        self.view.addSubview(self.cropButton)
        
        self.imageView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-50)
        }
        self.cameraButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.imageView.snp.bottom)
            make.left.bottom.equalToSuperview()
            make.width.equalToSuperview().dividedBy(3)
        }
        self.galleryButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.cameraButton)
            make.left.equalTo(self.cameraButton.snp.right)
            make.width.equalToSuperview().dividedBy(3)
            make.bottom.equalToSuperview()
        }
        self.cropButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.cameraButton)
            make.width.equalToSuperview().dividedBy(3)
            make.bottom.right.equalToSuperview()
        }
    }
    
    func setLogic() {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        cameraButton.rx.tap
            .flatMapLatest { [weak self] _ in
                return UIImagePickerController.rx.createWithParent(self) { picker in
                    picker.sourceType = .camera
                    picker.allowsEditing = false
                    }
                    .flatMap { $0.rx.didFinishPickingMediaWithInfo }
                    .take(1)
            }
            .map { info in
                return info[UIImagePickerControllerOriginalImage] as? UIImage
            }
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)
        
        galleryButton.rx.tap
            .flatMapLatest { [weak self] _ in
                return UIImagePickerController.rx.createWithParent(self) { picker in
                    picker.sourceType = .photoLibrary
                    picker.allowsEditing = false
                    }
                    .flatMap {
                        $0.rx.didFinishPickingMediaWithInfo
                    }
                    .take(1)
            }
            .map { info in
                return info[UIImagePickerControllerOriginalImage] as? UIImage
            }
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)
        
        cropButton.rx.tap
            .flatMapLatest { [weak self] _ in
                return UIImagePickerController.rx.createWithParent(self) { picker in
                    picker.sourceType = .photoLibrary
                    picker.allowsEditing = true
                    }
                    .flatMap { $0.rx.didFinishPickingMediaWithInfo }
                    .take(1)
            }
            .map { info in
                return info[UIImagePickerControllerEditedImage] as? UIImage
            }
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)
    }
}
