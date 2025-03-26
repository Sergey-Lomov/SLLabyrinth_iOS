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
        HStack {
            ZStack {
                GeometryReader { geometry in
                    let scale = scale(geometry: geometry)

                    if (showAreas) {
                        PathsGraphAreasView(
                            areas: generator.isolatedAreas.vertices.toArray(),
                            nodeSize: scale
                        )
                    }

                    if (showCycles) {
                        PathsGraphAreasView(areas: generator.cyclesAreas, nodeSize: scale)
                    }

                    FieldView<T>(field: generator.field, nodeSize: scale)

                    if (showPaths) {
                        PathsGraphView(
                            graph: generator.pathsGraph,
                            biColor: Color.yellow,
                            oneColor: Color.brown,
                            nodeSize: scale)
                    }

                    if (showFilteredPaths) {
                        PathsGraphView(
                            graph: generator.filteredGraph,
                            biColor: Color.cyan,
                            oneColor: Color.mint,
                            nodeSize: scale)
                    }
                }
            }
        }
        .padding(10)
        .id(viewId)

        controlPanel()
            .padding(10)
    }

    private func controlPanel() -> some View {
        VStack {
            Button("Time") {
                DispatchQueue.global(qos: .userInitiated).async {
                    let profiler = TimeProfiler()
                    profiler.execute(times: 10) {
                        generator.generateLabyrinth()
                    }
                    profiler.averageLog.printReport()
                }
            }

            Button("Regenerate") {
                let log = generator.generateLabyrinth()
                log.printReport()
                viewId = UUID()
            }

            Button("Search issue") {
                searchIssue()
            }

            Spacer()

            Button("Areas") { showAreas = !showAreas }
            Button("Paths") { showPaths = !showPaths }
            Button("Filtered") { showFilteredPaths = !showFilteredPaths }
            Button("Cycled") { showCycles = !showCycles }

            Spacer()

            Button("Restore collapse") { restore(.collapse) }
            Button("Restore paths") { restore(.paths) }
            Button("Restore isolated") { restore(.isolated) }
            Button("Restore cycles") { restore(.cycles) }

            Spacer()

            Button("Execute collapse") { execute(.collapse) }
            Button("Execute paths") { execute(.paths) }
            Button("Execute isolated") { execute(.isolated) }
            Button("Execute cycles") { execute(.cycles) }
        }
    }

    private func execute(_ step: GenerationStep) {
        generator.executeStep(step)
        viewId = UUID()
    }

    private func restore(_ step: GenerationStep) {
        generator.restoreSavedState(step: step)
        viewId = UUID()
    }

    // TODO: Remove testing code
    private func searchIssue() {
        var index = 1
        while generator.isolatedAreas.vertices.count == 1 {
            generator.generateLabyrinth()
            print("Generation finished: \(index)")
            index += 1
        }

        viewId = UUID()
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
