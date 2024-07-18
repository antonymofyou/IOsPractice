//
//  CanvasElementModel.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 13.07.2024.
//
import SwiftUI

struct PresentationModel: Decodable {
    var imageDictionary: ImageDictionaryModel
    var shapes: [CanvasElementModel]
}

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
    var textVerticalAlignment: String? // вертикальное выравнивание всего текстового блока который находится на элементе
    var text: [PartTextModel]?
    var imageId: String?
    var rotation: Double?
}

struct PartTextModel: Decodable {
    var alignment: String?  // выравнивание left right center у конкретного текста из текстового блока
    var text: [TextModel]?
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

