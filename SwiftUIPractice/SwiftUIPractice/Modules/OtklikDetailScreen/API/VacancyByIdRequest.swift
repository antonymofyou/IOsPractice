//
//  VacancyByIdRequest.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 04.07.2024.
//

import Foundation
import SerializedSwift
class VacancyByIdRequest: MainRequestClass {
    @Serialized(default: "")
    var vacancyId: String

    @Serialized(default: "")
    var status: String
}
