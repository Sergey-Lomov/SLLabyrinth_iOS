//
//  PathsGraphView.swift
//  SLLabyrinthIOS
//
//  Created by serhii.lomov on 11.03.2025.
//

import Foundation
import SwiftUI

struct PathsGraphView<T: Topology>: View {
    let graph: PathsGraph<T>
    let nodeSize: CGFloat

    var vertexSize: CGFloat { nodeSize * 0.3 }

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                ForEach(Array(graph.edges), id: \.self) { edge in
                    var transform = CGAffineTransform.identity
                        .translatedBy(x: 0, y: geometry.size.height)
                        .scaledBy(x: nodeSize, y: -nodeSize)
                    let path = edgePath(edge).copy(using: &transform)
                    if let path = path {
                        Path(path)
                            .stroke(Color.green, lineWidth: 4)
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
