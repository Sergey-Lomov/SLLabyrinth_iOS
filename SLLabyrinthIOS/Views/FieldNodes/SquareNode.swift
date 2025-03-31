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
        case is Solid<SquareTopology>:
            SquareSolidNode()
        case let element as OneWayHolder<SquareTopology>:
            OneWayHolderNode(element: element)
        case let element as Teleporter<SquareTopology>:
            TeleporterNode(element: element)
        case let element as PassagesBasedElement<SquareTopology>:
            SquarePassagesBasedNode(element: element)
        case is UndefinedElement<SquareTopology>:
            SquareUndefinedNode()
        default:
            Text("?")
        }
    }
}
