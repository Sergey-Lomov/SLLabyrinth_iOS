//
//  FieldNodeView.swift
//  SLLabyrinthIOS
//
//  Created by serhii.lomov on 10.03.2025.
//

import Foundation
import SwiftUI

struct FieldNodeView<T: Topology>: View {
    let node: Node<T>

    var body: some View {
        switch node {
        case let node as Node<SquareTopology>: SquareNode(node: node)
        default: Text("?")
        }
    }
}
