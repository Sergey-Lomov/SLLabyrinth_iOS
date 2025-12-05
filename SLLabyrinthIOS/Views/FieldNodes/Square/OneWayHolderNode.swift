//
//  OneWayHolderNode.swift
//  SLLabyrinthIOS
//
//  Created by serhii.lomov on 20.03.2025.
//

import Foundation
import SwiftUI

struct OneWayHolderNode: View {
    typealias Element = OneWayHolder<SquareTopology>
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
                let ways = SquareEdge.allCases.filter {
                    !element.walls.contains($0)
                }

                var transform = CGAffineTransform(scale: geometry)
                let rawWaysPath = CGPath.centerToEdgesPath(ways)
                if let waysPath = rawWaysPath.copy(using: &transform) {
                    let waysLineWidth = geometry.size.width / config.widthDivider
                    let waysStile = StrokeStyle(lineWidth: waysLineWidth, lineCap: .round)
                    Path(waysPath)
                        .stroke(config.mainColor, style: waysStile)
                }

                curvesChevrons(geometry: geometry, config: config)
            }
        }
        .background(config.backColor)
        .clipped()
    }

    @ViewBuilder
    private func curvesChevrons(geometry: GeometryProxy, config: FieldStyle.CurvesConfig) -> some View {
        ForEach(element.incomes, id: \.self) {
            curveChevron(
                config: config,
                geometry: geometry,
                edge: $0,
                income: true
            )
        }
        ForEach(element.outgoings, id: \.self) {
            curveChevron(
                config: config,
                geometry: geometry,
                edge: $0,
                income: false
            )
        }
    }

    @ViewBuilder
    private func curveChevron(
        config: FieldStyle.CurvesConfig,
        geometry: GeometryProxy,
        edge: SquareEdge,
        income: Bool
    ) -> some View {
        let angle = edgeArrowAngle(edge)
        let sizeScale = 1.0 / config.widthDivider * 1.25
        var transform = CGAffineTransform.identity
            .scaledBy(x: geometry.size.width,
                      y: geometry.size.height)
            .translatedBy(x: 0.5, y: 0.5)
            .rotated(by: angle)
            .translatedBy(x: 0.0, y: 0.5)
            .scaledBy(x: 1, y: income ? 1 : -1)
            .scaledBy(x: sizeScale, y: sizeScale)

        let rawPath = CGPath.chevronPath()
        let path = rawPath.copy(using: &transform)
        let lineWidth = geometry.size.width / 4.0 / config.widthDivider
        if let path = path {
            Path(path)
                .stroke(config.backColor, lineWidth: lineWidth)
        }
    }

    @ViewBuilder
    private func debugView() -> some View {
        GeometryReader { geometry in
            ZStack {
                debugWalls(geometry: geometry)
                debugArrows(geometry: geometry)
            }
        }
    }

    @ViewBuilder
    private func debugWalls(geometry: GeometryProxy) -> some View {
        var transform = CGAffineTransform(scale: geometry)
        let notPassages = element.incomes + element.outgoings + element.walls
        let unscaledPath = CGPath.nodeEdgesPath(notPassages)
        let path = unscaledPath.copy(using: &transform)

        if let path = path {
            Path(path)
                .stroke(Color.black, lineWidth: 4)
        }
    }

    @ViewBuilder
    private func debugArrows(geometry: GeometryProxy) -> some View {
        ForEach(element.outgoings, id: \.self) {
            debugArrow(geometry: geometry, edge: $0)
        }
    }

    @ViewBuilder
    private func debugArrow(geometry: GeometryProxy, edge: SquareEdge) -> some View {
        let angle = edgeArrowAngle(edge)
        var transform = CGAffineTransform.identity
            .scaledBy(x: geometry.size.width, y: geometry.size.height)
            .translatedBy(x: 0.5, y: 0.5)
            .rotated(by: angle)
            .translatedBy(x: 0.0, y: 0.5)
            .scaledBy(x: 0.75, y: 0.75)

        let arrowPath = CGPath.arrowPath()
        let path = arrowPath.copy(using: &transform)
        if let path = path {
            Path(path)
                .stroke(Color.black, lineWidth: 4)
        }
    }

    private func edgeArrowAngle(_ edge: SquareEdge) -> Double {
        switch edge {
        case .left: return Double.pi * 0.5
        case .right: return Double.pi * -0.5
        case .top: return Double.pi
        case .bottom: return 0
        }
    }
}

struct OneWayHolderNode_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ZStack(alignment: .center) {
                let element = OneWayHolder<SquareTopology>(
                    passages: [.top],
                    incomes: [.bottom],
                    outgoings: [.left],
                    walls: [.right]
                )
                OneWayHolderNode(element: element)
                    .frame(width: 75, height: 75)
            }
            .frame(width: 200, height: 200)
            .fieldStyle(.defaultCurves)
        }
    }
}

