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

        // 1. Clear old layers
        layer.sublayers?.forEach { $0.removeFromSuperlayer() }

        // 2. Geometry setup
        let center = CGPoint(x: rect.midX, y: rect.maxY)
        let radius = rect.width / 2
        let startAngle = CGFloat.pi
        var currentAngle = startAngle

        // 3. Convert padding to radians (4 degrees)
        let paddingDegrees: CGFloat = 2
        let paddingRadians = paddingDegrees * .pi / 180

        // 4. Normalize segments: total % used to proportion each angle
        let total = segments.reduce(0) { $0 + $1.percentage }

        // 5. Total available angle for segments after padding
        let totalPadding = paddingRadians * CGFloat(segments.count - 1)
        let totalAvailableAngle = CGFloat.pi - totalPadding

        // 6. Draw each segment
        for (index, segment) in segments.enumerated() {
            // 7. Each segment’s angle based on its percentage of total
            let angle = totalAvailableAngle * (segment.percentage / total)
            let endAngle = currentAngle + angle

            // 8. Create the path
            let path = UIBezierPath()
            path.move(to: center)
            path.addArc(withCenter: center, radius: radius, startAngle: currentAngle, endAngle: endAngle, clockwise: true)
            path.close()

            // 9. Create and configure shape layer
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = path.cgPath
            shapeLayer.fillColor = segment.color.cgColor
            shapeLayer.lineCap = .round
            layer.addSublayer(shapeLayer)

            // 10. Move to next segment, add padding if not the last
            currentAngle = endAngle
            if index < segments.count - 1 {
                currentAngle += paddingRadians
            }
        }
    }
}
