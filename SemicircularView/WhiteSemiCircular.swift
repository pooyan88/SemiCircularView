//
//  WhiteSemiCircular.swift
//  SemicircularView
//
//  Created by Pooyan J on 1/30/1404 AP.
//

import UIKit

class WhiteSemiCircularView: UIView {

    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

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
        // Title Label
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center

        // Subtitle Label
        subtitleLabel.font = UIFont.systemFont(ofSize: 16)
        subtitleLabel.textColor = .darkGray
        subtitleLabel.textAlignment = .center

        addSubview(titleLabel)
        addSubview(subtitleLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // Layout labels near the bottom-center of the semi-circle
        let labelHeight: CGFloat = 22
        let spacing: CGFloat = 6
        let totalHeight = labelHeight * 2 + spacing

        let startY = bounds.maxY - totalHeight - 10

        titleLabel.frame = CGRect(x: 0, y: startY, width: bounds.width, height: labelHeight)
        subtitleLabel.frame = CGRect(x: 0, y: titleLabel.frame.maxY + spacing, width: bounds.width, height: labelHeight)
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

        ctx.setFillColor(UIColor.white.cgColor)
        ctx.fillPath()
    }

    // MARK: - Public API

    func configure(title: String, subtitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}
