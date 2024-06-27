//
//  VKLoginResponse.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 27.06.2024.
//

import Foundation
import SerializedSwift

class VKLoginResponse: MainResponseClass {

    @Serialized(default: "")
    var nasotkuToken: String

    @Serialized(default: "")
    var device: String
}

