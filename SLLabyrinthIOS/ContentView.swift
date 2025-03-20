//
//  ContentView.swift
//  SLLabyrinthIOS
//
//  Created by serhii.lomov on 07.03.2025.
//

import SwiftUI

struct ContentView: View {
    static let config = {
        let config = GeneratorConfiguration<SquareTopology>.basic(size: (20, 20))

        config.setWeigth(StraightPathSuperposition<SquareTopology>.self, weight: 5.0)
        config.setWeigth(CornerPathSuperposition<SquareTopology>.self, weight: 2.0)
        config.setWeigth(JunctionSuperposition<SquareTopology>.self, weight: 1.0)
        config.setWeigth(DeadendSuperposition<SquareTopology>.self, weight: 0.5)
        config.setWeigth(OneWayHolderSuperposition<SquareTopology>.self, weight: 0.2)

        return config
    }()

    let generator = LabyrinthGenerator(configuration: ContentView.config)

    var body: some View {
        HStack {
            GenerationDebugView<SquareTopology>(generator: generator)
        }.onAppear() {
            let log = generator.generateLabyrinth()
            log.printReport()
        }
    }
}

#Preview {
    ContentView()
}
