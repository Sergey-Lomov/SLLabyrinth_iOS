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

    @State private var viewId = UUID()
    @State private var showAreas: Bool = true
    @State private var showPaths: Bool = false
    @State private var showFilteredPaths: Bool = false
    @State private var showCycles: Bool = true

    var body: some View {
        VStack {
            controlPanel()

            ZStack {
                GeometryReader { geometry in
                    let scale = scale(geometry: geometry)

                    if (showAreas) {
                        PathsGraphAreasView(areas: generator.isolatedAreas, nodeSize: scale)
                    }

                    if (showCycles) {
                        PathsGraphAreasView(areas: generator.cyclesAreas, nodeSize: scale)
                    }

                    FieldView<T>(field: generator.field, nodeSize: scale)

                    if (showPaths) {
                        PathsGraphView(
                            graph: generator.pathsGraph,
                            color: Color.yellow,
                            nodeSize: scale)
                    }

                    if (showFilteredPaths) {
                        PathsGraphView(
                            graph: generator.filteredGraph,
                            color: Color.green,
                            nodeSize: scale)
                    }
                }
            }
        }
        .padding(10)
        .id(viewId)
    }

    private func controlPanel() -> some View {
        VStack {
            HStack {
                Button("Time") {
                    let profiler = TimeProfiler()
                    profiler.execute(times: 10) {
                        generator.generateLabyrinth()
                    }
                    profiler.averageLog.printReport()
                }

                Button("Restore") {
                    generator.restoreSaved()
                    generator.calculateCyclesAreas()
                    viewId = UUID()
                }

                Button("Regenerate") {
                    let log = generator.generateLabyrinth()
                    log.printReport()
                    viewId = UUID()
                }

                Button("Resolve") {
                    generator.resolveCyclesAreas()
                    viewId = UUID()
                }
            }

            HStack {
                Button("Areas") { showAreas = !showAreas }
                Button("Paths") { showPaths = !showPaths }
                Button("Filtered") { showFilteredPaths = !showFilteredPaths }
                Button("Cycled") { showCycles = !showCycles }
            }
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
