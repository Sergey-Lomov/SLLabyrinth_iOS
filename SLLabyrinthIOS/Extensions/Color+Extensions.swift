//
//  Color+Extensions.swift
//  SLLabyrinthIOS
//
//  Created by serhii.lomov on 09.04.2025.
//

import Foundation
import SwiftUI

extension Color {
    static func randomSeeded(by value: Int) -> Color {
        var generator = SeededGenerator(seed: value)
        let r = Double.random(in: 0...1, using: &generator)
        let g = Double.random(in: 0...1, using: &generator)
        let b = Double.random(in: 0...1, using: &generator)
        return Color(red: r, green: g, blue: b)
    }
}
