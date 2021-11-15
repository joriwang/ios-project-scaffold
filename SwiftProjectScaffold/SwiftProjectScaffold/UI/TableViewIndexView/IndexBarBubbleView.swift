//
//  IndexBarBubbleView.swift
//  IndexBar
//
//  Created by rainedAllNight on 2020/9/16.
//  Copyright © 2020 Silhorse. All rights reserved.
//

import UIKit

public struct BubbleConfigure {
    public var font: UIFont = .systemFont(ofSize: 22, weight: .medium)
    public var textColor: UIColor = .white
    public var backgroundColor = UIColor.lightGray.withAlphaComponent(0.6)
}

class IndexBarBubbleView: UIView {

    private var label: UILabel?
    private var configure: BubbleConfigure

    init(frame: CGRect, configure: BubbleConfigure) {
        self.configure = configure
        super.init(frame: frame)
        let label = UILabel.init(frame: bounds)
        label.textColor = self.configure.textColor
        label.font = self.configure.font
        label.textAlignment = .center
        backgroundColor = .clear
        addSubview(label)
        self.label = label
    }

    public func hide() {
        UIView.animate(withDuration: 0.2) {
            self.alpha = 0
        }
    }

    func show(_ title: String?, on position: CGPoint) {
        label?.text = title
        center = position
        if alpha == 0 {
            alpha = 1
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(2.0)
        context?.setFillColor(configure.backgroundColor.cgColor)
        setDrawPath(context)
        context?.fillPath()
    }

    private func setDrawPath(_ context: CGContext?) {
        guard let context = context else {return}
        let width = bounds.width
        let height = bounds.height
        let originX = width/4
        let originY = height/4
        let radius = sqrt(pow(originX, 2) + pow(originY, 2))

        // Draw triangle
        context.move(to: CGPoint(x: width - originX, y: height * 0.5 - originY))
        context.addLine(to: CGPoint(x: width, y: height * 0.5))
        context.addLine(to: CGPoint(x: width - originX, y: height * 0.5 + originY))

        // Draw semicircle
        context.addArc(tangent1End: CGPoint(x: width * 0.5, y: height), tangent2End: CGPoint(x: width * 0.5 - originX, y: height * 0.5 + originY), radius: radius)
        context.addArc(tangent1End: CGPoint(x: 0, y: height * 0.5), tangent2End: CGPoint(x: width * 0.5 - originX, y: height * 0.5 - originY), radius: radius)
        context.addArc(tangent1End: CGPoint(x: width * 0.5, y: 0), tangent2End: CGPoint(x: width * 0.5 + originX, y: height * 0.5 - originY), radius: radius)
        context.closePath()
    }

}
