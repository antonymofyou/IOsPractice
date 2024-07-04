//
//  SetCandidateCommentResponse.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 04.07.2024.
//

import Foundation
import SerializedSwift

class SetCandidateCommentResponse: MainResponseClass {
    @Serialized(default: [:])
    var comment : [String: String]
}

