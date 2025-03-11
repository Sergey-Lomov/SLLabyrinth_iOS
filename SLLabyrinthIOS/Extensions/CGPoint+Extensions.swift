//
//  CGPoint+Extensions.swift
//  SLLabyrinthIOS
//
//  Created by serhii.lomov on 10.03.2025.
//

import Foundation

extension CGPoint {
    init(_ value: Float) {
        self.init(CGFloat(value))
    }

    init(_ value: CGFloat) {
        self.init(x: value, y: value)
    }

    init(_ point: (Float, Float)) {
        self.init(x: CGFloat(point.0), y: CGFloat(point.1))
    }
}

func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
    CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func + (point: CGPoint, scalar: CGFloat) -> CGPoint {
    CGPoint(x: point.x + scalar, y: point.y + scalar)
}

func + (point1: CGPoint, point2: CGPoint) -> CGPoint {
    CGPoint(x: point1.x + point2.x, y: point1.y + point2.y)
}

func - (point: CGPoint, scalar: CGFloat) -> CGPoint {
    CGPoint(x: point.x - scalar, y: point.y - scalar)
}

func - (point1: CGPoint, point2: CGPoint) -> CGPoint {
    CGPoint(x: point1.x - point2.x, y: point1.y - point2.y)
}
