//
//  SetCandidateCommentRequest.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 04.07.2024.
//

import Foundation
import SerializedSwift
class SetCandidateCommentRequest: MainRequestClass {
    @Serialized(default: "")
    var candidateId: String

    @Serialized(default: "")
    var action: String

    @Serialized(default: "")
    var commentFor: String

    @Serialized(default: "")
    var commentText: String
}

