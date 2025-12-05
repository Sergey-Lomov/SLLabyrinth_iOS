//
//  FieldStyle.swift
//  SLLabyrinthIOS
//
//  Created by serhii.lomov on 03.12.2025.
//

import Foundation
import SwiftUI

enum FieldStyle {
    struct CurvesConfig {
        let widthDivider: Double
        let mainColor: Color
        let backColor: Color
        let teleportColor: Color
    }

    case debug
    case curves(config: CurvesConfig)

    static let defaultCurves: FieldStyle = .curves(
        config: CurvesConfig(
            widthDivider: 2.0,
            mainColor: .teal,
            backColor: Color(red: 0.0, green: 0.0, blue: 0.5),
            teleportColor: .blue
        )
    )
}

struct FieldStyleKey: EnvironmentKey {
    static let defaultValue: FieldStyle = .debug
}

extension EnvironmentValues {
    var fieldStyle: FieldStyle {
        get { self[FieldStyleKey.self] }
        set { self[FieldStyleKey.self] = newValue}
    }
}

extension View {
    func fieldStyle(_ style: FieldStyle) -> some View {
        environment(\.fieldStyle, style)
    }
}
