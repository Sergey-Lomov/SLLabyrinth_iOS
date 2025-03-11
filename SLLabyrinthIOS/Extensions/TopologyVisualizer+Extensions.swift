//
//  TopologyVisualizer+Extensions.swift
//  SLLabyrinthIOS
//
//  Created by serhii.lomov on 10.03.2025.
//

import Foundation
import SwiftUI

extension Topology {
    static func visualScale(field: Field, geometry: GeometryProxy) -> Float {
        visualScale(field: field,
              width: Float(geometry.size.width),
              height: Float(geometry.size.height)
        )
    }
}
