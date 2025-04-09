//
//  SeededGenerator.swift
//  SLLabyrinthIOS
//
//  Created by serhii.lomov on 09.04.2025.
//

import Foundation

final class SeededGenerator: RandomNumberGenerator {
    private var state: UInt64

    init(seed: Int) {
        self.state = UInt64(seed)
    }

    func next() -> UInt64 {
        state ^= state >> 12
        state ^= state << 25
        state ^= state >> 27
        return state
    }
}
