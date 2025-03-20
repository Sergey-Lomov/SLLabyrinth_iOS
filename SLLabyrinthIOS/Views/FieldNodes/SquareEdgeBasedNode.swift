//
//  SquareEdgeBasedNode.swift
//  SLLabyrinthIOS
//
//  Created by serhii.lomov on 10.03.2025.
//

import Foundation
import SwiftUI

struct SquareEdgeBasedNode: View {
    typealias Element = EdgeBasedElement<SquareTopology>
    let element: Element

    var body: some View {
        GeometryReader { geometry in
            var transform = CGAffineTransform(scale: geometry)
            let path = elementPath(element).copy(using: &transform)

            if let path = path {
                Path(path)
                    .stroke(Color.black, lineWidth: 4)
            }
        }
    }

    private func elementPath(_ element: Element) -> CGPath {
        let edges = SquareEdge.allCases.filter { !element.passages.contains($0) }
        return CGPath.nodeEdgesPath(edges)
    }
}

struct SquareTopologyEdgeBasedNode_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ZStack(alignment: .center) {
                let element = Deadend<SquareTopology>(entrance: .right)
                SquareEdgeBasedNode(element: element)
                    .frame(width: 75, height: 75)
            }
            .frame(width: 100, height: 100)

            ZStack(alignment: .center) {
                let element = StraightPath<SquareTopology>(path: (.left, .right))
                SquareEdgeBasedNode(element: element)
                    .frame(width: 75, height: 75)
            }
            .frame(width: 100, height: 100)
        }
    }
}
