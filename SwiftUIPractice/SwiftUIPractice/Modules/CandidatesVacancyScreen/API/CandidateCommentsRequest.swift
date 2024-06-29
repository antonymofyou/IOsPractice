//
//  CandidateCommentsRequest.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 29.06.2024.
//

import Foundation
import SerializedSwift

class CandidateCommentsRequest: MainRequestClass {

    @Serialized(default: "")
    var candidateId: String

    @Serialized(default: "")
    var commentFor: String
}
