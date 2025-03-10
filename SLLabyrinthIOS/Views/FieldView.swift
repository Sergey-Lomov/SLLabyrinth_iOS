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
            let scale = CGFloat(T.visualScale(field: field, geometry: geometry))
            ZStack {
                ForEach(field.allNodes(), id: \.point) { node in
                    let cartesianPoint = T.visualPosition(node.point)
                    let cgPoint = CGPoint(cartesianPoint) * scale
                    FieldNodeView(node: node)
                        .frame(width: scale, height: scale)
                        .offset(x: cgPoint.x, y: geometry.size.height - cgPoint.y)
                }
            }
        }
    }
}
