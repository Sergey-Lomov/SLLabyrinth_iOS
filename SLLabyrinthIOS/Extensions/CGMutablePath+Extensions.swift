//
//  CGMutablePath+Extensions.swift
//  SLLabyrinthIOS
//
//  Created by serhii.lomov on 05.12.2025.
//

import Foundation
import CoreGraphics

extension CGMutablePath {
    func addUnitQuarterArc(center: CGPoint, from: Double) {
        addArc(
            center: center,
            radius: 0.5,
            startAngle: from,
            endAngle: from + .pi / 2,
            clockwise: false
        )
    }
}
