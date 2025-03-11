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

    var body: some View {
        GeometryReader { geometry in
            let scale = scale(geometry: geometry)
            ZStack {
                ForEach(field.allPoints(), id: \.self) { point in
                    let visualPoint = T.visualPosition(point)
                    let offset = offset(visualPoint, geometry: geometry, scale: scale)
                    if let element = field.element(at: point) {
                        FieldNodeView<T>(element: element)
                            .frame(width: scale, height: scale)
                            .offset(offset)
                    }
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
