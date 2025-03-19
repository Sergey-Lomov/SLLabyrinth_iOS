//
//  SquareSolidNode.swift
//  SLLabyrinthIOS
//
//  Created by serhii.lomov on 19.03.2025.
//

import Foundation
import SwiftUI

struct SquareSolidNode: View {
    var body: some View {
        GeometryReader { geometry in
            Color.black
                .frame(geometry.size)
        }
    }
}
