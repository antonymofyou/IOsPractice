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
    var alignment: TextAlignment

    var body: some View {
        HStack {
            if alignment == .leading {
                styledText(textArray: shape.text ?? [])
                Spacer()
            } else if alignment == .trailing {
                Spacer()
                styledText(textArray: shape.text ?? [])
            } else {
                Spacer()
                styledText(textArray: shape.text ?? [])
                Spacer()
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

