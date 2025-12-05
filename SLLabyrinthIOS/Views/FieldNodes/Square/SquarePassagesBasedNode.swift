//
//  SquarePassagesBasedNode.swift
//  SLLabyrinthIOS
//
//  Created by serhii.lomov on 10.03.2025.
//

import Foundation
import SwiftUI

struct SquarePassagesBasedNode: View {
    typealias Element = PassagesBasedElement<SquareTopology>
    let element: Element
    @Environment(\.fieldStyle) var style

    var body: some View {
        switch style {
        case .debug:
            debugView()
        case .curves(let config):
            curvesView(config)
        }
    }

    @ViewBuilder
    private func curvesView(_ config: FieldStyle.CurvesConfig) -> some View {
        GeometryReader { geometry in
            var transform = CGAffineTransform(scale: geometry)
            let path = rawCurvesPath().copy(using: &transform)
            let lineWidth = geometry.size.width / CGFloat(config.widthDivider)
            let strokeStyle = StrokeStyle.init(lineWidth: lineWidth, lineCap: .round, lineJoin: .round)

            if let path = path {
                Path(path)
                    .stroke(config.mainColor, style: strokeStyle)
            }
        }
        .background(config.backColor)
        .clipped()
    }

    private func rawCurvesPath() -> CGPath {
        switch element {
        case is CornerPath<SquareTopology>:
            return cornerCurvePath(passages: element.passages)
        default:
            return CGPath.centerToEdgesPath(element.passages)
        }
    }

    private func cornerCurvePath(passages: [SquareEdge]) -> CGPath {
        let path = CGMutablePath()

        if passages.contains(.top) {
            if passages.contains(.right) {
                let center = CGPoint(x: 1, y: 0)
                path.addUnitQuarterArc(center: center, from: .pi / 2)
            }
            if passages.contains(.left) {
                path.addUnitQuarterArc(center: .zero, from: 0)
            }
        }

        if passages.contains(.bottom) {
            if passages.contains(.right) {
                let center = CGPoint(x: 1, y: 1)
                path.addUnitQuarterArc(center: center, from: .pi )
            }
            if passages.contains(.left) {
                let center = CGPoint(x: 0, y: 1)
                path.addUnitQuarterArc(center: center, from: .pi / 2 * 3)
            }
        }

        return path
    }

    @ViewBuilder
    private func debugView() -> some View {
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
        let edges = SquareEdge.allCases.filter { !element.passages.contains($0) }
        return CGPath.nodeEdgesPath(edges)
    }
}

struct SquarePassagesBasedNode_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ZStack(alignment: .center) {
                let element = Deadend<SquareTopology>(passages: [.right])
                SquarePassagesBasedNode(element: element)
                    .frame(width: 75, height: 75)
            }
            .frame(width: 100, height: 100)

            ZStack(alignment: .center) {
                let element = StraightPath<SquareTopology>(passages: [.left, .right])
                SquarePassagesBasedNode(element: element)
                    .frame(width: 75, height: 75)
            }
            .frame(width: 100, height: 100)

            ZStack(alignment: .center) {
                let element = CornerPath<SquareTopology>(passages: [.left, .top])
                SquarePassagesBasedNode(element: element)
                    .frame(width: 75, height: 75)
            }
            .frame(width: 100, height: 100)
        }
        .fieldStyle(.defaultCurves)
    }
}
