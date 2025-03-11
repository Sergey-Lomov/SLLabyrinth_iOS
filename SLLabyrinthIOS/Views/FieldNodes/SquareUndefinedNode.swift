//
//  SquareUndefinedNode.swift
//  SLLabyrinthIOS
//
//  Created by serhii.lomov on 11.03.2025.
//

import Foundation
import SwiftUI

struct SquareUndefinedNode: View {
    var body: some View {
        GeometryReader { geometry in
            Color.mint.
                .frame(geometry.size)
        }
    }
}
