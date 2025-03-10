//
//  GenerationDebugView.swift
//  SLLabyrinthIOS
//
//  Created by serhii.lomov on 10.03.2025.
//

import Foundation
import SwiftUI

struct GenerationDebugView<T: Topology>: View {
    let field: Field<T>

    var body: some View {
        FieldView(field: field)
            .padding(10)
    }
}
