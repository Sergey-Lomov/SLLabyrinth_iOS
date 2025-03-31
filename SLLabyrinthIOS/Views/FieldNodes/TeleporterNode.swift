//
//  TeleporterNode.swift
//  SLLabyrinthIOS
//
//  Created by serhii.lomov on 29.03.2025.
//

import Foundation
import SwiftUI

struct TeleporterNode: View {
    typealias Element = Teleporter<SquareTopology>
    let element: Element

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                SquarePassagesBasedNode(element: element)
                Circle()
                    .fill(.blue)
                    .frame(geometry.size * 0.5)

                if element.type == .receiver {
                    Circle()
                        .stroke(.white)
                        .frame(geometry.size * 0.5)
                }

                if element.type == .sender {
                    Circle()
                        .stroke(.black)
                        .frame(geometry.size * 0.5)
                }
            }
        }
    }
}

struct TeleporterNode_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ZStack(alignment: .center) {
                let element = Teleporter<SquareTopology>(
                    target: SquarePoint(x: 0, y: 0),
                    type: .bidirectional,
                    passages: [.left, .right])
                TeleporterNode(element: element)
                    .frame(width: 75, height: 75)
            }
            .frame(width: 200, height: 200)
        }
    }
}


