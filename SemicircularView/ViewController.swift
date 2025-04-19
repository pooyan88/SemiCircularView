//
//  ViewController.swift
//  SemicircularView
//
//  Created by Pooyan J on 4/18/25.
//

import UIKit

class ViewController: UIViewController {
    
    let semiCircularView = SemiCircularProgressView(frame: CGRect(x: 50, y: 200, width: 300, height: 150))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        semiCircularView.segments = [
            SemiCircularSegment(color: .systemPurple, percentage: 10),
            SemiCircularSegment(color: .purple, percentage: 10),
            SemiCircularSegment(color: .systemPink, percentage: 10),
            SemiCircularSegment(color: .red, percentage: 5),
            SemiCircularSegment(color: .orange, percentage: 4),
            SemiCircularSegment(color: .yellow, percentage: 30),
            SemiCircularSegment(color: .systemGreen, percentage: 10),
            SemiCircularSegment(color: .green, percentage: 10),
            SemiCircularSegment(color: .cyan, percentage: 20),
            SemiCircularSegment(color: .systemBlue, percentage: 20),

        ]

        view.addSubview(semiCircularView)
    }
}
