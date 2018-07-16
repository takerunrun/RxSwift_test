//
//  CustomButton.swift
//  RxSample
//
//  Created by admin on 2018/07/07.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit

// アプリで使用するボタンのレギュレーション
class CustomButton: UIButton {
    
    enum Color {
        case green
        case clear
    }
    
    func set(title: String, font: UIFont, cornerRadius: CGFloat) {
        self.isExclusiveTouch = true
        setTitle(title, for: .normal)
        self.titleLabel?.baselineAdjustment = .alignCenters
        self.titleLabel?.font = font
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
    
    func setNormal(textColor: UIColor, backColor: UIColor) {
        setTitleColor(textColor, for: .normal)
        setBackgroundImage(self.createBackgroundImage(color: backColor), for: .normal)
    }
    
    func setHighlighted(textColor: UIColor, backColor: UIColor) {
        setTitleColor(textColor, for: .highlighted)
        setBackgroundImage(self.createBackgroundImage(color: backColor), for: .highlighted)
    }
    
    func setDisabled(textColor: UIColor, backColor: UIColor) {
        setTitleColor(textColor, for: .disabled)
        setBackgroundImage(self.createBackgroundImage(color: backColor), for: .disabled)
    }
    
    func setTextColor(normalColor: UIColor, highlitedColor: UIColor) {
        setTitleColor(normalColor, for: .normal)
        setTitleColor(highlitedColor, for: .highlighted)
    }
    
    func setBackColor(normalColor: UIColor, highlightedColor: UIColor) {
        setBackgroundImage(self.createBackgroundImage(color: normalColor), for: .normal)
        setBackgroundImage(self.createBackgroundImage(color: highlightedColor), for: .highlighted)
    }
    
    // 通常ボタン
//    func set(title: String, color: Color, font: UIFont, cornerRadius: CGFloat) {
//        self.isExclusiveTouch = true
//        setTitle(title, for: .normal)
//        self.titleLabel?.baselineAdjustment = .alignCenters
//        self.titleLabel?.font = font
//        self.layer.cornerRadius = cornerRadius
//        self.layer.masksToBounds = true
//
//
//
//
//        switch color {
//        case .green:
//            setBackgroundImage(self.createBackgroundImage(color: .green), for: .normal)
//            setBackgroundImage(self.createBackgroundImage(color: .white), for: .highlighted)
//            setTitleColor(.white, for: .normal)
//            setTitleColor(.green, for: .highlighted)
//
//        case .clear:
//            self.titleLabel?.textAlignment = .left
//            setBackgroundImage(self.createBackgroundImage(color: UIColor.clear), for: .normal)
//            let transparent = AppColor.lineLightGray.withAlphaComponent(0.6)
//            setBackgroundImage(self.createBackgroundImage(color: transparent), for: .highlighted)
//            setTitleColor(.gray, for: .normal)
//            setTitleColor(.green, for: .highlighted)
//
//        }
//    }
    
    func set(title: String, color: Color, font: UIFont, cornerRadius: CGFloat, image: UIImage) {
        self.setImage(image, for: .normal)
        self.set(title: title, font: font, cornerRadius: cornerRadius)
    }
    
    // 下線付きボタン
    func setUnderlined(title: String, fontSize: CGFloat, bold: Bool) {
        self.isExclusiveTouch = true
        let font: UIFont = bold ? .boldSystemFont(ofSize: fontSize) : .systemFont(ofSize: fontSize)
        let attrs: [NSAttributedStringKey : Any] = [
            .font            : font,
            .foregroundColor : UIColor.black,
            .underlineStyle  : 1]
        let text = NSMutableAttributedString(string: title, attributes: attrs)
        setAttributedTitle(text, for: .normal)
    }
    
    // 通常ボタンの背景を生成
    private func createBackgroundImage(color: UIColor) -> UIImage {
        // 1x1のbitmapを作成
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()!
        // bitmapを塗りつぶし
        context.setFillColor(color.cgColor)
        context.fill(rect)
        // UIImageに変換
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}
