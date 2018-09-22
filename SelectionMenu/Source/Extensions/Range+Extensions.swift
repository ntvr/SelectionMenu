//
//  Range+Extensions.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 15/07/2018.
//  Copyright © 2018 Michal Štembera. All rights reserved.
//

import Foundation

protocol ClampableRange {
    associatedtype Bound: Comparable

    var upperBound: Bound { get }
    var lowerBound: Bound { get }
}

extension ClampableRange {
    func clamp(_ value: Bound) -> Bound {
        return min(max(lowerBound, value), upperBound)
    }
}

extension Range: ClampableRange { }
extension ClosedRange: ClampableRange { }
