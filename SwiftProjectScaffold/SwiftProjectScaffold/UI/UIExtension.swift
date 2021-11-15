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
        let controller = TZImagePickerController(maxImagesCount: maxCount, columnNumber: 4, delegate: delegate)!
        controller.modalPresentationStyle = .fullScreen
        controller.naviBgColor = UIColor(hex: "#ffcc00")
        controller.allowPickingGif = false
        controller.allowPickingVideo = false
        controller.allowPickingImage = true
        controller.allowPreview = false
        controller.allowCrop = true
        
        return controller
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
        while let sup = superV, deepLimit > 0 {
            if sup.isKind(of: UICollectionView.self), let target = sup as? UICollectionView {
                target.reloadData()
                break
            }
            deepLimit -= 1
            superV = sup.superview
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
        while let sup = superV, deepLimit > 0 {
            if sup.isKind(of: UITableView.self), let target = sup as? UITableView {
                target.reloadData()
                break
            }
            deepLimit -= 1
            superV = sup.superview
        }
    }
}
