//
//  FieldNodeView.swift
//  SLLabyrinthIOS
//
//  Created by serhii.lomov on 10.03.2025.
//

import Foundation
import SwiftUI

struct FieldNodeView<T: Topology>: View {
    let element: T.Field.Element

    var body: some View {
        switch element {
        case let element as SquareTopology.Field.Element:
            SquareNode(element: element)
        default: Text("?")
        }
    }
}
