//
//  AnalogClockDelegate.swift
//  AnalogClock
//
//  Created by Maxim Makhun on 21.01.2023.
//

import Foundation

protocol AnalogClockDelegate: AnyObject {
    
    /// Emitted whenever `AnalogClock` updates hour, minute and second.
    func didUpdate(_ hour: Measurement<UnitDuration>,
                   minute: Measurement<UnitDuration>,
                   second: Measurement<UnitDuration>)
    
    /// Emitted whenever `AnalogClock` updates hour, minute and second (in either degrees or radians).
    func didUpdate(_ hour: Measurement<UnitAngle>,
                   minute: Measurement<UnitAngle>,
                   second: Measurement<UnitAngle>)
}
