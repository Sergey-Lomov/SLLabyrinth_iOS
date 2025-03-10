//
//  FieldView.swift
//  SLLabyrinthIOS
//
//  Created by serhii.lomov on 10.03.2025.
//

import Foundation
import SwiftUI

struct FieldView<T: Topology>: View {
    let field: Field<T>

    var body: some View {
        GeometryReader { geometry in
            let scale = scale(geometry: geometry)
            ZStack {
                ForEach(field.allNodes(), id: \.point) { node in
                    let point = T.visualPosition(node.point)
                    let offset = offset(point, geometry: geometry, scale: scale)
                    FieldNodeView(node: node)
                        .frame(width: scale, height: scale)
                        .offset(offset)
                }
            }
        }
    }

    private func scale(geometry: GeometryProxy) -> CGFloat {
        CGFloat(T.visualScale(field: field, geometry: geometry))
    }

    private func offset(_ point: (Float, Float), geometry: GeometryProxy, scale: CGFloat) -> CGPoint {
        let scale = CGFloat(T.visualScale(field: field, geometry: geometry))
        return CGPoint(
            x: CGFloat(point.0 - 0.5) * scale,
            y: geometry.size.height - CGFloat(point.1 + 0.5) * scale
        )
    }
}
