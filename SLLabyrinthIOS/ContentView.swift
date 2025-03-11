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
    let field = LabyrinthGenerator(configuration: ContentView.config).generateLabyrinth()

    var body: some View {
        HStack {
            GenerationDebugView<SquareTopology>(field: field)
        }
    }
}

#Preview {
    ContentView()
}
