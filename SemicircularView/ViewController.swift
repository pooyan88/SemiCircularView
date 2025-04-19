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
            SemiCircularSegment(color: .red, percentage: 20),
            SemiCircularSegment(color: .orange, percentage: 15),
            SemiCircularSegment(color: .yellow, percentage: 20),
            SemiCircularSegment(color: .green, percentage: 20),
        ]

        view.addSubview(semiCircularView)
    }
}
