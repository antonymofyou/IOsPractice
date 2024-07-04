//
//  CandidateCommentResponse.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 04.07.2024.
//

import Foundation
import SerializedSwift

class CandidateCommentResponse: MainResponseClass {
    @Serialized(default: [])
    var comments : [[String: String]]
}
