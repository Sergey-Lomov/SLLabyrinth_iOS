//
//  SquareNode.swift
//  SLLabyrinthIOS
//
//  Created by serhii.lomov on 10.03.2025.
//

import Foundation
import SwiftUI

struct SquareNode: View {
    let node: Node<SquareTopology>

    var body: some View {
        switch node.element {
        case let element as EdgeBasedElement<SquareTopology>:
            SquareEdgeBasedNode(element: element)
        default: Text("?")
        }
    }
}
