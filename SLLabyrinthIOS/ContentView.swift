//
//  ContentView.swift
//  SLLabyrinthIOS
//
//  Created by serhii.lomov on 07.03.2025.
//

import SwiftUI
import SLLabyrinthGenerator

struct ContentView: View {
    let field = LabyrinthGenerator(configuration: GeneratorConfiguration()).generateLabyrinth()

    var body: some View {
        GenerationDebugView(field: field)
    }
}

#Preview {
    ContentView()
}
