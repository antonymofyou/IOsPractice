//
//  CandidateByVacancyResponse.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 29.06.2024.
//

import Foundation
import SerializedSwift

final class CandidateByVacancyResponse: MainResponseClass {
    @Serialized(default: [])
    var candidates : [[String: String]]

}
