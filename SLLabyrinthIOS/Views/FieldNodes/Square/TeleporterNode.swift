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
    @Environment(\.fieldStyle) var style

    var body: some View {
        switch style {
        case .debug:
            debugView()
        case .curves(let config):
            curvesView(config)
        }
    }

    @ViewBuilder
    private func curvesView(_ config: FieldStyle.CurvesConfig) -> some View {
        GeometryReader { geometry in
            ZStack {
                SquarePassagesBasedNode(element: element)

                switch element.type {
                case .bidirectional:
                    Circle()
                        .fill(config.mainColor)
                        .frame(geometry.size * 0.75)
                    Circle()
                        .fill(config.teleportColor)
                        .frame(geometry.size * 0.5)
                case .sender:
                    RoundedRectangle(cornerSize: geometry.size * 0.15)
                        .fill(config.mainColor)
                        .frame(geometry.size * 0.75)
                    RoundedRectangle(cornerSize: geometry.size * 0.1)
                        .fill(config.teleportColor)
                        .frame(geometry.size * 0.5)

                case .receiver:
                    let lineWidth = geometry.size.width * 0.1
                    RoundedRectangle(cornerSize: geometry.size * 0.15)
                        .fill(config.mainColor)
                        .frame(geometry.size * 0.75)
                    RoundedRectangle(cornerSize: geometry.size * 0.1)
                        .stroke(config.teleportColor, lineWidth: lineWidth)
                        .frame(geometry.size * 0.5)
                }
            }
        }
    }

    @ViewBuilder
    private func debugView() -> some View {
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

            ZStack(alignment: .center) {
                let element = Teleporter<SquareTopology>(
                    target: SquarePoint(x: 0, y: 0),
                    type: .sender,
                    passages: [.left, .right])
                TeleporterNode(element: element)
                    .frame(width: 75, height: 75)
            }

            ZStack(alignment: .center) {
                let element = Teleporter<SquareTopology>(
                    target: SquarePoint(x: 0, y: 0),
                    type: .receiver,
                    passages: [.left, .right])
                TeleporterNode(element: element)
                    .frame(width: 75, height: 75)
            }
        }
        .frame(width: 100, height: 100)
        .fieldStyle(.defaultCurves)
    }
}


