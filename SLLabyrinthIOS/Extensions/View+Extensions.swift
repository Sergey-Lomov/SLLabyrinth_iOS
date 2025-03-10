//
//  View+Extensions.swift
//  SLLabyrinthIOS
//
//  Created by serhii.lomov on 10.03.2025.
//

import Foundation
import SwiftUI

extension View {
    func offset(_ point: CGPoint) -> some View {
        offset(x: point.x, y: point.y)
    }

    func frame(_ size: CGSize) -> some View {
        frame(width: size.width, height: size.height)
    }
}
