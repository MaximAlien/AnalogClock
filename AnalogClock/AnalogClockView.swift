//
//  AnalogClockView.swift
//  AnalogClock
//
//  Created by Maxim Makhun on 21.01.2023.
//

import UIKit

class AnalogClockView: UIView {
    
    var analogClock = AnalogClock()
    
    var hourLayer = CAShapeLayer()
    
    var minuteLayer = CAShapeLayer()
    
    var secondLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        applyStyle(to: hourLayer, color: .red)
        layer.addSublayer(hourLayer)
        
        applyStyle(to: minuteLayer, color: .black)
        layer.addSublayer(minuteLayer)
        
        applyStyle(to: secondLayer, color: .blue)
        layer.addSublayer(secondLayer)
        
        analogClock.delegate = self
        analogClock.start()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        redraw(hourLayer)
        redraw(minuteLayer)
        redraw(secondLayer)
    }
    
    func applyStyle(to shapeLayer: CAShapeLayer, color: UIColor) {
        shapeLayer.lineWidth = 3.0
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.backgroundColor = UIColor.clear.cgColor
    }
    
    func redraw(_ layer: CAShapeLayer) {
        layer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        layer.bounds = bounds
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: bounds.midX, y: bounds.midY))
        bezierPath.addLine(to: CGPoint(x: bounds.midX, y: 10.0))
        layer.path = bezierPath.cgPath
    }
}

extension AnalogClockView: AnalogClockDelegate {
    
    func didUpdate(_ hour: Measurement<UnitDuration>,
                   minute: Measurement<UnitDuration>,
                   second: Measurement<UnitDuration>) {
        // No-op
    }
    
    func didUpdate(_ hour: Measurement<UnitAngle>,
                   minute: Measurement<UnitAngle>,
                   second: Measurement<UnitAngle>) {
        if hour.unit != .radians,
           minute.unit != .radians,
           second.unit != .radians {
            return
        }
        
        hourLayer.transform = CATransform3DMakeRotation(hour.value, 0.0, 0.0, 1.0)
        minuteLayer.transform = CATransform3DMakeRotation(minute.value, 0.0, 0.0, 1.0)
        secondLayer.transform = CATransform3DMakeRotation(second.value, 0.0, 0.0, 1.0)
    }
}
