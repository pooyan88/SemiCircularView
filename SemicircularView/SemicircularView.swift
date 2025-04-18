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

        let center = CGPoint(x: rect.midX, y: rect.maxY) // Bottom center
        let radius = rect.width / 2
        let startAngle = CGFloat.pi // 180 degrees
        var currentAngle = startAngle
        
        for segment in segments {
            let endAngle = currentAngle + (CGFloat.pi * (segment.percentage / 100))
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
