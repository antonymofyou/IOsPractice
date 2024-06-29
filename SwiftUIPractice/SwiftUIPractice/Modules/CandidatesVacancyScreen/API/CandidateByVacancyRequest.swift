//
//  CandidateByVacancyRequest.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 29.06.2024.
//

import Foundation
import SerializedSwift

final class CandidateByVacancyRequest: MainRequestClass {
    @Serialized(default: "")
    var vacancyId: String

    @Serialized(default: "")
    var status: String
}
