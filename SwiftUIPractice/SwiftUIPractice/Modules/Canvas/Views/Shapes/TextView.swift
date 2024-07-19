//
//  TextView.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 16.07.2024.
//

import SwiftUI

struct TextView: View {
    var shape: CanvasElementModel
    var scale: CGFloat

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(shape.text ?? [], id: \.alignment) { partTextModel in
                HStack {
                    if partTextModel.alignment == "left" {
                        styledText(textArray: partTextModel.text ?? [])
                        Spacer()
                    } else if partTextModel.alignment == "right" {
                        Spacer()
                        styledText(textArray: partTextModel.text ?? [])
                    } else if partTextModel.alignment == "center" {
                        Spacer()
                        styledText(textArray: partTextModel.text ?? [])
                        Spacer()
                    } else {
                        styledText(textArray: partTextModel.text ?? [])
                    }
                }
            }
        }
    }

    func styledText(textArray: [TextModel]) -> Text {
        var resultText = Text("")
        
        for textModel in textArray {
            let text = Text(textModel.text)
                .foregroundColor(Color(hex: textModel.fontColor ?? "#000000"))
                .font(.system(size: textModel.fontSize ?? 14))

            switch textModel.type {
            case "bold":
                resultText = resultText + text.bold()
            case "italic":
                resultText = resultText + text.italic()
            case "underline":
                resultText = resultText + text.underline()
            case "strikethrough":
                resultText = resultText + text.strikethrough()
            default:
                resultText = resultText + text
            }
        }

        return resultText
    }
}
