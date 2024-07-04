//
//  VacancyByIdResponse.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 04.07.2024.
//

import Foundation
import SerializedSwift

class VacancyByIdResponse: MainResponseClass {
    @Serialized(default: [])
    var candidates : [[String: String]]
}
