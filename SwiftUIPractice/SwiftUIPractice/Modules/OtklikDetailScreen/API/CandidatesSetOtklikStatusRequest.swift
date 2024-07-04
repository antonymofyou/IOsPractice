//
//  CandidatesSetOtklikStatusRequest.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 04.07.2024.
//

import Foundation
import SerializedSwift

class CandidatesSetOtklikStatusRequest: MainRequestClass {
    @Serialized(default: "")
    var otklikId: String

    @Serialized(default: "")
    var toStatusName: String
}
