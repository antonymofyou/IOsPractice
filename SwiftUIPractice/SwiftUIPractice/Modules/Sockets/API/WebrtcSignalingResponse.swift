//
//  WebrtcSignalingResponse.swift
//  SwiftUIPractice
//
//  Created by Кирилл Щёлоков on 15.07.2024.
//

import SerializedSwift

class WebrtcSignalingResponse: MainResponseClass {
    @Serialized(default:"")
    var dataType: String
    @Serialized(default:"")
    var data: String
}
