//
//  ContentView.swift
//  SLLabyrinthIOS
//
//  Created by serhii.lomov on 07.03.2025.
//

import SwiftUI

struct ContentView: View {
    typealias ST = SquareTopology

    static let config = {
        var config = GeneratorConfiguration<SquareTopology>.basic(size: (40, 40))

        var provider = config.superpositionsProvider
        provider.reqisterSuperposition(OneWayHolderSuperposition<ST>.self)
        provider.reqisterSuperposition(TeleporterSuperposition<ST>.self)
//        provider.reqisterSuperposition(BridgeSuperposition<ST>.self)

        config.setWeigth(StraightPathSuperposition<ST>.self, weight: 5.0)
        config.setWeigth(CornerPathSuperposition<ST>.self, weight: 2.0)
        config.setWeigth(JunctionSuperposition<ST>.self, weight: 1.0)
        config.setWeigth(DeadendSuperposition<ST>.self, weight: 0.5)
        config.setWeigth(TeleporterSuperposition<ST>.self, weight: 0.01)
        config.setWeigth(OneWayHolderSuperposition<ST>.self, weight: 0.04)
        config.setWeigth(BridgeSuperposition<ST>.self, weight: 0.04)

        let isolatedStrategy = SizeBasedIsolatedAreasStrategy<ST>()
        let randomMerge = RandomMergeIsolatedAreasStrategy<ST>()
        let onewayMerge = OnewaysMergeIsolatedAreasStrategy<ST>()
        let teleportMerge = TeleporterIsolatedAreasStrategy<ST>(allowOneway: true)
        isolatedStrategy.add(from: 0, to: 1, weight: 1, strategy: randomMerge)
        isolatedStrategy.add(from: 0.075, to: 1, weight: 1, strategy: onewayMerge)
        isolatedStrategy.add(from: 0.1, to: 1, weight: 0.25, strategy: teleportMerge)
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
