//
//  CGPath+Extensions.swift
//  SLLabyrinthIOS
//
//  Created by serhii.lomov on 20.03.2025.
//

import Foundation
import CoreGraphics

extension CGPath {
    static func arrowPath() -> CGPath {
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0.0, y: -0.5))
        path.addLine(to: CGPoint(x: 0.0, y: 0.5))
        path.move(to: CGPoint(x: 0.33, y: 0.16))
        path.addLine(to: CGPoint(x: 0.0, y: 0.5))
        path.addLine(to: CGPoint(x: -0.33, y: 0.16))
        return path
    }

    static func nodeEdgesPath(_ edges: [SquareEdge]) -> CGPath {
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: 0))

        if (edges.contains(.left)) {
            path.addLine(to: CGPoint(x: 0, y: 1))
        } else {
            path.move(to: CGPoint(x: 0, y: 1))
        }

        if (edges.contains(.bottom)) {
            path.addLine(to: CGPoint(x: 1, y: 1))
        } else {
            path.move(to: CGPoint(x: 1, y: 1))
        }

        if (edges.contains(.right)) {
            path.addLine(to: CGPoint(x: 1, y: 0))
        } else {
            path.move(to: CGPoint(x: 1, y: 0))
        }

        if (edges.contains(.top)) {
            path.addLine(to: CGPoint(x: 0, y: 0))
        } else {
            path.move(to: CGPoint(x: 0, y: 0))
        }

        // Overlap for unconnected lines fix
        if (edges.contains(.left)) {
            path.addLine(to: CGPoint(x: 0, y: 1))
        }

        return path
    }
}
