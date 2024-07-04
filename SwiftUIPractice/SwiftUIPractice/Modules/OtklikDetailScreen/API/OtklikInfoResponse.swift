//
//  OtklikInfoResponse.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 04.07.2024.
//

import Foundation
import SerializedSwift

class OtklikInfoResponse: MainResponseClass {
    @Serialized(default: [])
    var answers : [[String: String]]

    @Serialized(default: [:])
    var info : [String: String]

    @Serialized(default: [])
    var statusTransfers : [String]
}
