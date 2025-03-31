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

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                walls(geometry: geometry)
                arrows(geometry: geometry)
            }
        }
    }

    @ViewBuilder
    private func walls(geometry: GeometryProxy) -> some View {
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
    private func arrows(geometry: GeometryProxy) -> some View {
        ForEach(element.outgoings, id: \.self) {
            arrow(geometry: geometry, edge: $0)
        }
    }

    @ViewBuilder
    private func arrow(geometry: GeometryProxy, edge: SquareEdge) -> some View {
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
                    incomes: [],
                    outgoings: [.left, .bottom],
                    walls: [.right]
                )
                OneWayHolderNode(element: element)
                    .frame(width: 75, height: 75)
            }
            .frame(width: 200, height: 200)
        }
    }
}

