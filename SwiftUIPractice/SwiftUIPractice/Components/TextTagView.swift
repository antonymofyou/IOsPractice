//
//  TextTagView.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 14.06.2024.
//

import SwiftUI

struct TextTagView: View {
    let rawText: String

    var body: some View {
        styledText(from: rawText)
    }
}

private func styledText(from htmlString: String) -> Text {
    let components = parseHTMLString(htmlString)
    return components.reduce(Text("")) { $0 + $1 }
}

private func parseHTMLString(_ htmlString: String) -> [Text] {
    var result: [Text] = []
    var attributes: [String: Bool] = [:]

    let pattern = "(<b>|<i>|<u>|<s>|</b>|</i>|</u>|</s>)" // Регулярное выражение для нахождения тегов
    let regex = try! NSRegularExpression(pattern: pattern, options: []) // Компилирует регулярное выражение из pattern. Используется для поиска всех соответствий в строке.
    let nsString = htmlString as NSString // Преобразует входящую строку в NSString, чтобы работать с NSRange, который требуется для методов регулярных выражений.
    let matches = regex.matches(in: htmlString, options: [], range: NSRange(location: 0, length: nsString.length)) //Все совпадения в строке на основе регулярного выражения.

    var lastRangeEnd = 0

    //Проходит через все совпадения регулярного выражения в строке.
    for match in matches {
        let range = match.range //Диапазон текущего совпаденияю.

        // Обработка текста между тегами
        if lastRangeEnd < range.location {
            let textPart = nsString.substring(with: NSRange(location: lastRangeEnd, length: range.location - lastRangeEnd))
            result.append(applyAttributes(to: Text(textPart), attributes: attributes))
        }

        // Обновление флагов на основе тегов.
        let tag = nsString.substring(with: range)
        switch tag {
        case "<b>":
            attributes["isBold"] = true
        case "</b>":
            attributes["isBold"] = false
        case "<i>":
            attributes["isItalic"] = true
        case "</i>":
            attributes["isItalic"] = false
        case "<u>":
            attributes["isUnderline"] = true
        case "</u>":
            attributes["isUnderline"] = false
        case "<s>":
            attributes["isStrikethrough"] = true
        case "</s>":
            attributes["isStrikethrough"] = false
        default:
            break
        }

        lastRangeEnd = range.location + range.length
    }

    // Обработка оставшегося текста.
    if lastRangeEnd < nsString.length {
        let textPart = nsString.substring(from: lastRangeEnd)
        result.append(applyAttributes(to: Text(textPart), attributes: attributes))
    }

    return result
}

private func applyAttributes(to text: Text, attributes: [String: Bool]) -> Text {
    var modifiedText = text

    if let isBold = attributes["isBold"], isBold {
        modifiedText = modifiedText.bold()
    }
    if let isItalic = attributes["isItalic"], isItalic {
        modifiedText = modifiedText.italic()
    }
    if let isUnderline = attributes["isUnderline"], isUnderline {
        modifiedText = modifiedText.underline()
    }
    if let isStrikethrough = attributes["isStrikethrough"], isStrikethrough {
        modifiedText = modifiedText.strikethrough()
    }

    return modifiedText
}

#Preview {
    TextTagView(rawText: "Это <b>пример</b> текста <s><i>для</i></s> разбиения")
}
