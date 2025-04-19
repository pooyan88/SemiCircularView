//
//  SemicircularView.swift
//  SemicircularView
//
//  Created by Pooyan J on 4/18/25.
//

import UIKit

struct SemiCircularSegment {
    let color: UIColor
    let percentage: CGFloat
}

class SemiCircularProgressView: UIView {
    var segments: [SemiCircularSegment] = [] {
        didSet {
            setNeedsDisplay() // Redraw whenever segments are updated
        }
    }

    override func draw(_ rect: CGRect) {
        guard !segments.isEmpty else { return }

        // Clear any existing layers to avoid stacking
        layer.sublayers?.forEach { $0.removeFromSuperlayer() }

        let center = CGPoint(x: rect.midX, y: rect.maxY)
        let radius = rect.width / 2
        let startAngle = CGFloat.pi
        var currentAngle = startAngle

        // Normalize based on total percentage
        let total = segments.reduce(0) { $0 + $1.percentage }

        for segment in segments {
            let angle = CGFloat.pi * (segment.percentage / total)
            let endAngle = currentAngle + angle

            let path = UIBezierPath()
            path.move(to: center)
            path.addArc(withCenter: center, radius: radius, startAngle: currentAngle, endAngle: endAngle, clockwise: true)
            path.close()

            let shapeLayer = CAShapeLayer()
            shapeLayer.path = path.cgPath
            shapeLayer.fillColor = segment.color.cgColor

            layer.addSublayer(shapeLayer)

            currentAngle = endAngle
        }
    }
}
