//
//  PathsGraphAreasView.swift
//  SLLabyrinthIOS
//
//  Created by serhii.lomov on 11.03.2025.
//

import Foundation
import SwiftUI

struct PathsGraphAreasView<T: Topology>: View {
    let areas: [PathsGraphArea<T>]
    let nodeSize: CGFloat

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(areas, id: \.id) { area in
                    ForEach(Array(area.graph.points), id: \.self) { point in
                        Color.randomSeeded(by: area.id)
                            .frame(nodeSize)
                            .offset(offset(point, geometry: geometry))
                    }
                }
            }
        }
    }

    private func offset(_ point: T.Point, geometry: GeometryProxy) -> CGPoint {
        let visualPoint = T.visualPosition(point)
        let x = CGFloat(visualPoint.0 - 0.5) * nodeSize
        let y = geometry.size.height - CGFloat(visualPoint.1 + 0.5) * nodeSize
        return CGPoint(x: x, y: y)
    }
}
