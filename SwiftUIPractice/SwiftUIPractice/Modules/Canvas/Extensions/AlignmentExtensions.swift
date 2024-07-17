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
        case "leading":
            return .leading
        case "trailing":
            return .trailing
        case "center":
            return .center
        case "topleading":
            return .topLeading
        case "toptrailing":
            return .topTrailing
        case "bottomleading":
            return .bottomLeading
        case "bottomtrailing":
            return .bottomTrailing
        default:
            return .center
        }
    }
}

