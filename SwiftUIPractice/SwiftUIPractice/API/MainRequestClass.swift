//
//  MainRequestClass.swift
//  SwiftUIPractice
//
//  Created by Кирилл Щёлоков on 12.06.2024.
//

import Foundation
import SerializedSwift

class MainRequestClass: API_root_class {
    @Serialized(default: "")
    var device: String
}
