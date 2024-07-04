//
//  CandidatesByVacancyResponse.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 02.07.2024.
//

import Foundation
import SerializedSwift

class CandidatesByVacancyResponse: MainResponseClass {
    @Serialized(default: [])
    var candidates : [[String: String]]
}

