//
//  SquareNode.swift
//  SLLabyrinthIOS
//
//  Created by serhii.lomov on 10.03.2025.
//

import Foundation
import SwiftUI

struct SquareNode: View {
    let element: SquareTopology.Field.Element

    var body: some View {
        switch element {
        case let element as Solid<SquareTopology>:
            SquareEdgeBasedNode(element: element)
                .background(Color.black)
        case let element as EdgeBasedElement<SquareTopology>:
            SquareEdgeBasedNode(element: element)
        case is UndefinedElement<SquareTopology>:
            SquareUndefinedNode()
        default: Text("?")
        }
    }
}
