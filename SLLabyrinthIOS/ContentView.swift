//
//  ContentView.swift
//  SLLabyrinthIOS
//
//  Created by serhii.lomov on 07.03.2025.
//

import SwiftUI

struct ContentView: View {
    static let config = GeneratorConfiguration<SquareTopology>(
        size: (10, 10)
    )
    let generator = LabyrinthGenerator(configuration: ContentView.config)

    var body: some View {
        HStack {
            GenerationDebugView<SquareTopology>(generator: generator)
        }.onAppear() {
            generator.generateLabyrinth()
            generator.field.setElement(at: SquarePoint(x: 0, y: 0), element: nil)
        }
    }
}

#Preview {
    ContentView()
}
