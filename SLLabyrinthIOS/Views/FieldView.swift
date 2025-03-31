//
//  FieldView.swift
//  SLLabyrinthIOS
//
//  Created by serhii.lomov on 10.03.2025.
//

import Foundation
import SwiftUI

struct FieldView<T: Topology>: View {
    let field: T.Field
    let nodeSize: CGFloat

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(field.allPoints().toArray(), id: \.self) { point in
                    let offset = offset(point, geometry: geometry)
                    let element = field.element(at: point)
                    FieldNodeView<T>(element: element)
                        .frame(nodeSize)
                        .offset(offset)
                }
            }
        }
    }

    private func offset(_ point: T.Point, geometry: GeometryProxy) -> CGPoint {
        let visualPoint = T.visualPosition(point)
        let x = CGFloat(visualPoint.0 - 0.5) * nodeSize
        let y = geometry.size.height - CGFloat(visualPoint.1 + 0.5) * nodeSize
        return CGPoint(x: x, y: y)
    }
}
