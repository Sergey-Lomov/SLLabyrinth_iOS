//
//  GenerationDebugView.swift
//  SLLabyrinthIOS
//
//  Created by serhii.lomov on 10.03.2025.
//

import Foundation
import SwiftUI

struct GenerationDebugView<T: Topology>: View {
    let field: T.Field

    var body: some View {
        FieldView<T>(field: field)
            .padding(10)
    }
}
