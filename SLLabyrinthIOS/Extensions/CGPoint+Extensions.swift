//
//  CGPoint+Extensions.swift
//  SLLabyrinthIOS
//
//  Created by serhii.lomov on 10.03.2025.
//

import Foundation

extension CGPoint {
    init(_ point: (Float, Float)) {
        self.init(x: CGFloat(point.0), y: CGFloat(point.1))
    }
}

func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
    CGPoint(x: point.x * scalar, y: point.y * scalar)
}
