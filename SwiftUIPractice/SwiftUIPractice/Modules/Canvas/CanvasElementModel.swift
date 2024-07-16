//
//  CanvasElementModel.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 13.07.2024.
//
import SwiftUI


struct CanvasElementModel: Identifiable, Decodable {
    var id: Int
    var type: String
    var x: CGFloat
    var y: CGFloat
    var width: CGFloat
    var height: CGFloat
    var borderColor: String?
    var color: String?
    var borderWidth: CGFloat?
    var cornerRadius: CGFloat?
    var zIndex: CGFloat?
    var text: [TextModel]?
    var imageId: String?
    var rotation: Double?
}

struct TextModel: Decodable {
    var text: String
    var type: String?
    var fontSize: CGFloat?
    var fontColor: String?
}


struct ImageDictionaryModel: Decodable {
    var imageDictionary: [String: String]
}

struct PresentationModel: Decodable {
    var imageDictionary: ImageDictionaryModel
    var shapes: [CanvasElementModel]
}
