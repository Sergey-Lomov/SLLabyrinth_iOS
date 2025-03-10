//
//  SquareEdgeBasedNode.swift
//  SLLabyrinthIOS
//
//  Created by serhii.lomov on 10.03.2025.
//

import Foundation
import SwiftUI

struct SquareEdgeBasedNode: View {
    typealias Element = EdgeBasedElement<SquareTopology>
    let element: Element

    var body: some View {
        GeometryReader { geometry in
            var transform = CGAffineTransform(scale: geometry)
            let path = elementPath(element).copy(using: &transform)

            if let path = path {
                Path(path)
                    .stroke(Color.black, lineWidth: 4)
            }
        }
    }

    private func elementPath(_ element: Element) -> CGPath {
        let path = CGMutablePath()

        path.move(to: CGPoint(x: 0, y: 0))

        if (!element.passages.contains(.left)) {
            path.addLine(to: CGPoint(x: 0, y: 1))
        } else {
            path.move(to: CGPoint(x: 0, y: 1))
        }

        if (!element.passages.contains(.bottom)) {
            path.addLine(to: CGPoint(x: 1, y: 1))
        } else {
            path.move(to: CGPoint(x: 1, y: 1))
        }

        if (!element.passages.contains(.right)) {
            path.addLine(to: CGPoint(x: 1, y: 0))
        } else {
            path.move(to: CGPoint(x: 1, y: 0))
        }

        if (!element.passages.contains(.top)) {
            path.addLine(to: CGPoint(x: 0, y: 0))
        } else {
            path.move(to: CGPoint(x: 0, y: 0))
        }

        // Overlap for unconnected lines fix
        if (!element.passages.contains(.left)) {
            path.addLine(to: CGPoint(x: 0, y: 1))
        }

        return path
    }
}

struct SquareTopologyEdgeBasedNode_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ZStack(alignment: .center) {
                let element = Deadend<SquareTopology>(entrance: .right)
                SquareEdgeBasedNode(element: element)
                    .frame(width: 75, height: 75)
            }
            .frame(width: 100, height: 100)

            ZStack(alignment: .center) {
                let element = StraightPath<SquareTopology>(path: (.left, .right))
                SquareEdgeBasedNode(element: element)
                    .frame(width: 75, height: 75)
            }
            .frame(width: 100, height: 100)
        }
    }
}
