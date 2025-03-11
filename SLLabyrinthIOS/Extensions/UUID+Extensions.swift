//
//  UUID+Extensions.swift
//  SLLabyrinthIOS
//
//  Created by serhii.lomov on 11.03.2025.
//

import Foundation
import SwiftUI

extension UUID {
    func toColor() -> Color {
        let hash = uuidString.hashValue
        let r = Double((hash >> 16) & 0xFF ) / 255.0
        let g = Double((hash >> 8) & 0xFF ) / 255.0
        let b = Double(hash & 0xFF ) / 255.0
        return Color(red: r, green: g, blue: b)
    }
}
