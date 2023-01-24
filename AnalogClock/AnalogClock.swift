//
//  AnalogClock.swift
//  AnalogClock
//
//  Created by Maxim Makhun on 21.01.2023.
//

import Foundation
import OSLog

class AnalogClock {
    
    weak var delegate: AnalogClockDelegate?
    
    var timer: Timer?
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [weak self] _ in
            guard let self = self else { return }
            
            let calendar = Calendar(identifier: .gregorian)
            let dateComponents = calendar.dateComponents([.hour, .minute, .second], from: Date())
            
            guard let hour = dateComponents.hour,
                  let minute = dateComponents.minute,
                  let second = dateComponents.second else {
                      return
                  }
            
            let hourValue = Measurement(value: Double(hour), unit: UnitDuration.hours)
            let minuteValue = Measurement(value: Double(minute), unit: UnitDuration.minutes)
            let secondValue = Measurement(value: Double(second), unit: UnitDuration.seconds)
            
            self.delegate?.didUpdate(hourValue,
                                     minute: minuteValue,
                                     second: secondValue)
            
            os_log("Analog time (raw). Hour: %@, minute: %@, second: %@",
                   log: OSLog.default,
                   type: .debug,
                   String(hourValue.value),
                   String(minuteValue.value),
                   String(secondValue.value))
            
            let hourInDegrees = (360.0 / (12.0 * 60.0 * 60)) * Double((hour >= 12 ? hour - 12 : hour) * 60 * 60 + minute * 60 + second)
            let minuteInDegress = (360.0 / (60.0 * 60.0)) * Double(minute * 60 + second)
            let secondInDegress = (360.0 / 60.0) * Double(second)
            
            let hourMeasurementInDegrees = Measurement(value: hourInDegrees, unit: UnitAngle.degrees)
            let minuteMeasurementInDegrees = Measurement(value: minuteInDegress, unit: UnitAngle.degrees)
            let secondMeasurementInDegrees = Measurement(value: secondInDegress, unit: UnitAngle.degrees)
            
            self.delegate?.didUpdate(hourMeasurementInDegrees,
                                     minute: minuteMeasurementInDegrees,
                                     second: secondMeasurementInDegrees)
            
            os_log("Analog time (degrees). Hour: %@, minute: %@, second: %@",
                   log: OSLog.default,
                   type: .debug,
                   String(hourInDegrees),
                   String(minuteInDegress),
                   String(secondInDegress))
            
            let hourInRadians = hourMeasurementInDegrees.converted(to: .radians)
            let minuteInRadians = minuteMeasurementInDegrees.converted(to: .radians)
            let secondInRadians = secondMeasurementInDegrees.converted(to: .radians)
            
            self.delegate?.didUpdate(hourInRadians,
                                     minute: minuteInRadians,
                                     second: secondInRadians)
            
            os_log("Analog time (radians). Hour: %@, minute: %@, second: %@",
                   log: OSLog.default,
                   type: .debug,
                   String(hourInRadians.value),
                   String(minuteInRadians.value),
                   String(secondInRadians.value))
        })
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
    }
}
