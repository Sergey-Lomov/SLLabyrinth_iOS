//
//  CGAffineTransform+Extensions.swift
//  SLLabyrinthIOS
//
//  Created by serhii.lomov on 10.03.2025.
//

import Foundation
import SwiftUI

extension CGAffineTransform {
    init(scale: CGSize) {
        self.init(scaleX: scale.height, y: scale.width)
    }

    init(scale: GeometryProxy) {
        self.init(scale: scale.size)
    }
}
