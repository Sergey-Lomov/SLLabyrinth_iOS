//
//  SquareSolidNode.swift
//  SLLabyrinthIOS
//
//  Created by serhii.lomov on 19.03.2025.
//

import Foundation
import SwiftUI

struct SquareSolidNode: View {
    @Environment(\.fieldStyle) var style

    var body: some View {
        switch style {
        case .debug:
            debugView()
        case .curves:
            EmptyView()
        }
    }

    @ViewBuilder
    private func debugView() -> some View {
        GeometryReader { geometry in
            ZStack {
                Color.black
                    .frame(geometry.size)

                var transform = CGAffineTransform(scale: geometry)
                let unscaledPath = CGPath.nodeEdgesPath(SquareEdge.allCases)
                let path = unscaledPath.copy(using: &transform)

                if let path = path {
                    Path(path)
                        .stroke(Color.black, lineWidth: 4)
                }
            }
        }
    }
}
