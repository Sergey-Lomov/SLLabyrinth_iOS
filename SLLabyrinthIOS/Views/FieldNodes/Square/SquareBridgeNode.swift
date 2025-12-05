//
//  SquareBridgeNode.swift
//  SLLabyrinthIOS
//
//  Created by serhii.lomov on 08.04.2025.
//

import Foundation
import SwiftUI

struct SquareBridgeNode: View {
    typealias Element = Bridge<SquareTopology>
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
            ZStack {
                var transform = CGAffineTransform(scale: geometry)
                let rawHPath = CGPath.centerToEdgesPath([.left, .right])
                let rawVPath = CGPath.centerToEdgesPath([.top, .bottom])
                let hPath = rawHPath.copy(using: &transform)
                let vPath = rawVPath.copy(using: &transform)

                if let hPath = hPath, let vPath = vPath {
                    let verticalTop = Bool.random()
                    let lineWidth = geometry.size.width / CGFloat(config.widthDivider)
                    let topPath = verticalTop ? vPath : hPath
                    let bottomPath = verticalTop ? hPath : vPath
                    let style = StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round)

                    Path(bottomPath)
                        .stroke(config.mainColor, style: style)
                    Rectangle()
                        .fill(config.backColor)
                        .frame(geometry.size * 0.75)
                    Path(topPath)
                        .stroke(config.mainColor, style: style)
                }
            }
        }
        .background(config.backColor)
        .clipped()
    }

    @ViewBuilder
    private func debugView() -> some View {
        GeometryReader { geometry in
            ZStack {
                var transform = CGAffineTransform(scale: geometry)
                let unscaledPath = bridgePath()
                let path = unscaledPath.copy(using: &transform)

                if let path = path {
                    Path(path)
                        .stroke(Color.black, lineWidth: 4)
                }
            }
        }
    }

    private func bridgePath() -> CGPath {
        let path = CGMutablePath()
        let h_gap = 0.2
        let v_gap = 0.2
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: h_gap, y: v_gap))
        path.addLine(to: CGPoint(x: h_gap, y: 1 - v_gap))
        path.addLine(to: CGPoint(x: 0, y: 1))
        path.move(to: CGPoint(x: 1, y: 1))
        path.addLine(to: CGPoint(x: 1 - h_gap, y: 1 - v_gap))
        path.addLine(to: CGPoint(x: 1 - h_gap, y: v_gap))
        path.addLine(to: CGPoint(x: 1, y: 0))
        return path
    }
}

struct SquareBridgeNode_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ZStack(alignment: .center) {
                let element = Bridge<SquareTopology>(
                    paths: [
                        [.top, .bottom],
                        [.left, .right]
                    ]
                )
                SquareBridgeNode(element: element)
                    .frame(width: 75, height: 75)
            }
            .frame(width: 200, height: 200)
        }
        .fieldStyle(.defaultCurves)
    }
}

