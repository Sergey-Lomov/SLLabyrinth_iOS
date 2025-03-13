//
//  ContentView.swift
//  SLLabyrinthIOS
//
//  Created by serhii.lomov on 07.03.2025.
//

import SwiftUI

struct ContentView: View {
    static let config = GeneratorConfiguration<SquareTopology>(
        size: (40, 40)
    )
    let generator = LabyrinthGenerator(configuration: ContentView.config)

    var body: some View {
        HStack {
            GenerationDebugView<SquareTopology>(generator: generator)
        }.onAppear() {
            _ = generator.generateLabyrinth()
        }
    }
}

#Preview {
    ContentView()
}
