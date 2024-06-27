//
//  VKLoginRequest.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 27.06.2024.
//

import Foundation
import SerializedSwift
class VkLoginRequest: API_root_class {

    @Serialized(default: "")
    var vkToken: String

    @Serialized(default: "")
    var vkUserId: String
}

