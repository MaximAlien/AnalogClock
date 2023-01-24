//
//  ViewController.swift
//  AnalogClock
//
//  Created by Maxim Makhun on 21.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var analogClockView: AnalogClockView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        analogClockView = AnalogClockView(frame: .zero)
        analogClockView.translatesAutoresizingMaskIntoConstraints = false
        analogClockView.backgroundColor = .green
        analogClockView.layer.cornerRadius = 100.0
        view.addSubview(analogClockView)
        
        let analogClockViewConstraints = [
            analogClockView.widthAnchor.constraint(equalToConstant: 200.0),
            analogClockView.heightAnchor.constraint(equalToConstant: 200.0),
            analogClockView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            analogClockView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(analogClockViewConstraints)
    }
}
