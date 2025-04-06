//
//  ContentView.swift
//  SLLabyrinthIOS
//
//  Created by serhii.lomov on 07.03.2025.
//

import SwiftUI

struct ContentView: View {
    static let config = {
        var config = GeneratorConfiguration<SquareTopology>.basic(size: (40, 40))

        var provider = config.superpositionsProvider
        provider.reqisterSuperposition(OneWayHolderSuperposition<SquareTopology>.self)
        provider.reqisterSuperposition(TeleporterSuperposition<SquareTopology>.self)

        config.setWeigth(StraightPathSuperposition<SquareTopology>.self, weight: 5.0)
        config.setWeigth(CornerPathSuperposition<SquareTopology>.self, weight: 2.0)
        config.setWeigth(JunctionSuperposition<SquareTopology>.self, weight: 1.0)
        config.setWeigth(DeadendSuperposition<SquareTopology>.self, weight: 0.5)
        config.setWeigth(TeleporterSuperposition<SquareTopology>.self, weight: 0.01)
        config.setWeigth(OneWayHolderSuperposition<SquareTopology>.self, weight: 0.04)

        let isolatedStrategy = SizeBasedIsolatedAreasStrategy<SquareTopology>()
        let randomMerge = RandomMergeIsolatedAreasStrategy<SquareTopology>()
        let onewayMerge = OnewaysMergeIsolatedAreasStrategy<SquareTopology>()
        let teleportMerge = TeleporterIsolatedAreasStrategy<SquareTopology>(allowOneway: true)
        isolatedStrategy.add(from: 0, to: 1, weight: 1, strategy: randomMerge)
        isolatedStrategy.add(from: 0.075, to: 1, weight: 1, strategy: onewayMerge)
        isolatedStrategy.add(from: 0.1, to: 1, weight: 0.5, strategy: teleportMerge)
        config.isolatedAreasStrategy = isolatedStrategy

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
