//
//  SemicircularView.swift
//  SemicircularView
//
//  Created by Pooyan J on 4/18/25.
//

import UIKit

class PercentageSemicircleView: UIView {
    
    var segments: [Segment] = [] {
        didSet {
            setNeedsLayout()
        }
    }
    
    struct Segment {
        let percentage: CGFloat
        let color: UIColor
    }
    
    private var segmentLayers: [CAShapeLayer] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Clear previous layers
        segmentLayers.forEach { $0.removeFromSuperlayer() }
        segmentLayers.removeAll()
        
        let center = CGPoint(x: bounds.midX, y: bounds.maxY)
        let radius = min(bounds.width, bounds.height * 2) * 0.9
        
        var startAngle: CGFloat = .pi // Start from left (180 degrees)
        let totalPercentage = segments.reduce(0) { $0 + $1.percentage }
        
        for segment in segments {
            let normalizedPercentage = segment.percentage / totalPercentage
            let endAngle = startAngle + .pi * normalizedPercentage
            
            // Create the segment path
            let path = UIBezierPath()
            path.move(to: center)
            path.addArc(withCenter: center,
                      radius: radius,
                      startAngle: startAngle,
                      endAngle: endAngle,
                      clockwise: true)
            path.close()
            
            // Create and configure the layer
            let layer = CAShapeLayer()
            layer.path = path.cgPath
            layer.fillColor = segment.color.cgColor
            layer.strokeColor = UIColor.white.cgColor
            layer.lineWidth = 1.0
            
            self.layer.addSublayer(layer)
            segmentLayers.append(layer)
            
            startAngle = endAngle
        }
        
        // Add the total value label
        let totalLabel = UILabel()
        totalLabel.text = "م ۰۰۰,۰۰۰,۰۰۰" // Your total value
        totalLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        totalLabel.textAlignment = .center
        totalLabel.frame = CGRect(x: 0, y: bounds.height - 30, width: bounds.width, height: 30)
        addSubview(totalLabel)
    }
}
