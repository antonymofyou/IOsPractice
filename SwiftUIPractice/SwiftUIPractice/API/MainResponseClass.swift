//
//  MainResponseClass.swift
//  SwiftUIPractice
//
//  Created by Кирилл Щёлоков on 12.06.2024.
//

import Foundation
import SerializedSwift

class MainResponseClass:API_root_class{
    @Serialized(default:"")
    var success:String

    @Serialized(default:"")
    var message:String
}
