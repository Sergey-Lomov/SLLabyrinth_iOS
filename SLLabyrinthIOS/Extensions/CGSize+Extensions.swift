//
//  CGSize+Extensions.swift
//  SLLabyrinthIOS
//
//  Created by serhii.lomov on 29.03.2025.
//

import Foundation

func * (lhs: CGSize, rhs: CGFloat) -> CGSize {
    CGSize(width: lhs.width * rhs, height: lhs.height * rhs)
}

func * (lhs: CGFloat, rhs: CGSize) -> CGSize { rhs * lhs }
