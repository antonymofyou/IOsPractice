//
//  VacancyResponse.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 13.06.2024.
//

import Foundation
import SerializedSwift

class VacancyResponse: MainResponseClass {

    @Serialized(default: [])
    var vacancies : [[String: String]]
}


