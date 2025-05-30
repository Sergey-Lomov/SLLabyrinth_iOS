//
//  PathsGraphView.swift
//  SLLabyrinthIOS
//
//  Created by serhii.lomov on 11.03.2025.
//

import Foundation
import SwiftUI

struct EdgesColors {
    let map: Dictionary<PathsEdgeType, Color>
    let undefined: Color
}

struct PathsGraphView<T: Topology>: View {
    private let strokeStyle = StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round)

    let graph: PathsGraph<T>
    let colors: EdgesColors
    let nodeSize: CGFloat

    var vertexSize: CGFloat { nodeSize * 0.3 }

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                ForEach(Array(graph.edges), id: \.self) { edge in
                    var transform = edgeTransform(edge, geometry: geometry)
                    let path = edgePath(edge).copy(using: &transform)

                    let color = colors.map[edge.type] ?? colors.undefined
                    if let path = path {
                        Path(path)
                            .stroke(color, style: strokeStyle)
                            .frame(width: 10, height: 10)
                    }
                }

                ForEach(Array(graph.vertices), id: \.self) { vertex in
                    let offset = offset(vertex.point, geometry: geometry)
                    Circle()
                        .fill(Color.yellow)
                        .frame(vertexSize)
                        .offset(offset)
                }
            }
        }
    }

    private func edgeTransform(_ edge: PathsGraphEdge<T>, geometry: GeometryProxy) -> CGAffineTransform {
        let isTeleportEdge = edge.type == .onewayTeleporter || edge.type == .bidirectionalTeleporter
        let delta = isTeleportEdge ? CGFloat(nodeSize * 0.05) : CGFloat(0)
        return CGAffineTransform.identity
            .translatedBy(x: delta, y: geometry.size.height + delta)
            .scaledBy(x: nodeSize, y: -nodeSize)
    }

    private func offset(_ point: T.Point, geometry: GeometryProxy) -> CGPoint {
        let visualPoint = T.visualPosition(point)
        let x = CGFloat(visualPoint.0) * nodeSize - vertexSize / 2.0
        let y = geometry.size.height - CGFloat(visualPoint.1) * nodeSize - vertexSize / 2.0
        return CGPoint(x: x, y: y)
    }

    private func edgePath(_ edge: PathsGraphEdge<T>) -> CGPath {
        let path = CGMutablePath()

        let from = T.visualPosition(edge.from.point)
        path.move(to: CGPoint(from))

        for point in edge.points {
            let adapted = T.visualPosition(point)
            path.addLine(to: CGPoint(adapted))
        }

        return path
    }
}
