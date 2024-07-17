//
//  AlignmentExtensions.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 17.07.2024.
//

import SwiftUI

extension Alignment {
    static func from(string: String) -> Alignment {
        switch string.lowercased() {
        case "top":
            return .top
        case "bottom":
            return .bottom
        case "center":
            return .center
        default:
            return .center
        }
    }
}

