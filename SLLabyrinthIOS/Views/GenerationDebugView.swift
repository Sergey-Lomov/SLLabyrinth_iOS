//
//  GenerationDebugView.swift
//  SLLabyrinthIOS
//
//  Created by serhii.lomov on 10.03.2025.
//

import Foundation
import SwiftUI

struct GenerationDebugView<T: Topology>: View {
    let generator: LabyrinthGenerator<T>

    var body: some View {
        VStack {
            HStack {
                Button("Recalculate") {
                    let profiler = TimeProfiler()
                    profiler.execute(times: 5) {
                        generator.generateLabyrinth()
                    }
                    profiler.averageLog.printReport()
                }
            }
            ZStack {
                GeometryReader { geometry in
                    let scale = scale(geometry: geometry)
                    PathsGraphAreasView(areas: generator.isolatedAreas, nodeSize: scale)
                    FieldView<T>(field: generator.field, nodeSize: scale)
                    PathsGraphView(graph: generator.pathsGraph, nodeSize: scale)
                }
            }
            .padding(10)
        }
    }

    private func scale(geometry: GeometryProxy) -> CGFloat {
        CGFloat(T.visualScale(field: generator.field, geometry: geometry))
    }

    private func offset(_ point: T.Point, geometry: GeometryProxy, nodeScale: CGFloat) -> CGPoint {
        let adapted = T.visualPosition(point)
        return CGPoint(
            x: CGFloat(adapted.0) * nodeScale,
            y: geometry.size.height - CGFloat(adapted.1) * nodeScale
        )
    }
}
