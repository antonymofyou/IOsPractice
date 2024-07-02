//
//  CandidatesByVacancyRequest.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 02.07.2024.
//

import Foundation
import SerializedSwift

class CandidatesByVacancyRequest: MainRequestClass {
    @Serialized(default: "")
    var vacancyId: String

    @Serialized(default: "")
    var status: String
}
