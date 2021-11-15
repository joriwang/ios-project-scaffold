//
//  ViewController.swift
//  ChongYaProjectScaffold
//
//  Created by Jori on 2021/11/5.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    private var count: Int = 0
    private var globalCount: Int = 0

    @IBOutlet private var actionButton: UIButton!
    @IBOutlet private var label: UILabel!

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = R.color.launchBackgroundColor()
        // Do any additional setup after loading the view.

        actionButton.rx.tap.map { [weak self] () -> String in
            guard let self = self else { return "" }
            self.count += 1
            return "\(self.count)"
        }.bind(to: label.rx.text).disposed(by: disposeBag)

        view.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer()
        view.addGestureRecognizer(gesture)
        gesture.rx.event.map { [weak self] (_) -> String in
            guard let self = self else { return "" }
            self.globalCount += 1
            return "\(self.globalCount)"
        }.bind(to: self.actionButton.rx.title(for: .normal)).disposed(by: disposeBag)
    }
}
