//
//  TopologyVisualizer+Extensions.swift
//  SLLabyrinthIOS
//
//  Created by serhii.lomov on 10.03.2025.
//

import Foundation

extension Topology {
    static func visualScale(field: Field, size: CGSize) -> Float {
        visualScale(field: field,
              width: Float(size.width),
              height: Float(size.height)
        )
    }
}
