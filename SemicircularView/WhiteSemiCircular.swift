//
//  WhiteSemiCircular.swift
//  SemicircularView
//
//  Created by Pooyan J on 1/30/1404 AP.
//

import UIKit

struct SemiCircleInfo {
    let fillColor: UIColor
    let title: String
    let subtitle: String
}

class ConfigurableSemiCircularView: UIView {

    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private var fillColor: UIColor = .white // default

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupLabels()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
        setupLabels()
    }

    private func setupLabels() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel.textColor = .lightGray
        titleLabel.textAlignment = .center

        subtitleLabel.font = UIFont.systemFont(ofSize: 30)
        subtitleLabel.textColor = .darkGray
        subtitleLabel.textAlignment = .center

        addSubview(titleLabel)
        addSubview(subtitleLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let labelHeight: CGFloat = 22
        let spacing: CGFloat = 6
        let totalHeight = labelHeight * 2 + spacing

        let startY = bounds.maxY - totalHeight - 30

        titleLabel.frame = CGRect(x: 0, y: startY, width: bounds.width, height: labelHeight)
        subtitleLabel.frame = CGRect(x: 0, y: titleLabel.frame.maxY + spacing + 20, width: bounds.width, height: labelHeight)
    }

    override func draw(_ rect: CGRect) {
        guard let ctx = UIGraphicsGetCurrentContext() else { return }

        let center = CGPoint(x: rect.midX, y: rect.maxY)
        let radius = rect.width / 2
        let startAngle = CGFloat.pi
        let endAngle = CGFloat.pi * 2

        ctx.move(to: center)
        ctx.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        ctx.closePath()

        ctx.setFillColor(fillColor.cgColor)
        ctx.fillPath()
    }

    // MARK: - Configuration Method

    func configure(with info: SemiCircleInfo) {
        self.fillColor = info.fillColor
        titleLabel.text = info.title
        subtitleLabel.text = info.subtitle
        setNeedsDisplay()
    }
}

