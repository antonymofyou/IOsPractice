//
//  OtklikInfoRequest.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 04.07.2024.
//

import Foundation
import SerializedSwift

class OtklikInfoRequest: MainRequestClass {
    @Serialized(default: "")
    var otklikId: String
}
