//
//  UIExtension.swift
//  ChongYaProjectScaffold
//
//  Created by Jori on 2021/11/9.
//

import Foundation
import UIKit
import TZImagePickerController
import RxSwift
import RxCocoa
import Hue

extension TZImagePickerController {
    static func makeInstance<T: TZImagePickerControllerDelegate>(withMaxCount maxCount: Int, delegate: T) -> TZImagePickerController {
        let vc = TZImagePickerController(maxImagesCount: maxCount, columnNumber: 4, delegate: delegate)!
        vc.modalPresentationStyle = .fullScreen
        vc.naviBgColor = UIColor(hex: "#ffcc00")
        vc.allowPickingGif = false
        vc.allowPickingVideo = false
        vc.allowPickingImage = true
        vc.allowPreview = false
        vc.allowCrop = true
        
        return vc
    }
}

extension UIView {
    func setCornerRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}

extension Reactive where Base: UIScrollView {
    var contentSize: ControlEvent<CGSize> {
        let source = base.rx.observeWeakly(CGSize.self, "contentSize")
        return ControlEvent(events: source.map { newSize in
            return newSize ?? CGSize.zero
        })
    }
}

extension UICollectionView {
    func registerNib(nibName: String, forCellReuseIdentifier: String) {
        self.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: forCellReuseIdentifier)
    }
}

extension UICollectionViewCell {
    @objc func refreshSuper() {
        var superV = superview
        var deepLimit = 1000
        while let s = superV, deepLimit > 0 {
            if s.isKind(of: UICollectionView.self) {
                (s as! UICollectionView).reloadData()
                break
            }
            deepLimit = deepLimit - 1
            superV = s.superview
        }
    }
}

extension UITableView {
    func registerNib(nibName: String, forCellReuseIdentifier: String) {
        self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: forCellReuseIdentifier)
    }
}

extension UITableViewCell {
    func refreshSuper() {
        var superV = superview
        var deepLimit = 1000
        while let s = superV, deepLimit > 0 {
            if s.isKind(of: UITableView.self) {
                (s as! UITableView).reloadData()
                break
            }
            deepLimit = deepLimit - 1
            superV = s.superview
        }
    }
}
