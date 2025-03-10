//
//  View+Extensions.swift
//  SLLabyrinthIOS
//
//  Created by serhii.lomov on 10.03.2025.
//

import Foundation
import SwiftUI

extension View {
    func offset(_ point: (Float, Float)) -> some View {
        offset(x: CGFloat(point.0), y: CGFloat(point.1))
    }
}
