//
//  RatingTable.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 05.07.2024.
//

import SwiftUI

struct RatingTable: View {
    var symbols: [Symbol]
    var title: String
    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .padding()

            Grid(symbols: symbols, raws: determineColumns(count: symbols.count))
                .border(Color.black, width: 1)
        }
    }

    // Вычесляет корень от количества элементов в массиве, для длины строк в таблице
    func determineColumns(count: Int) -> Int {
        return Int(ceil(sqrt(Double(count))))
    }
}

enum Symbol {
    case checkmark, cross, intermediate
}

struct TableCell: View {
    let symbol: Symbol?

    var body: some View {
        ZStack {
            Rectangle()
                .stroke(Color.black, lineWidth: 1)
            if let symbol = symbol {
                SymbolView(symbol: symbol)
                    .frame(minWidth: 25, maxWidth: 35, minHeight: 25, maxHeight: 35)
            }
        }
    }
}

struct SymbolView: View {
    let symbol: Symbol

    var body: some View {
        switch symbol {
        case .checkmark:
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .foregroundColor(.green)
        case .cross:
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .foregroundColor(.red)
        case .intermediate:
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .foregroundColor(.orange)
        }
    }
}

struct Grid: View {
    let symbols: [Symbol]
    let raws: Int

    var body: some View {
        let columns = (symbols.count + raws - 1) / raws

        VStack(spacing: 0) {
            ForEach(0..<columns, id: \.self) { column in
                HStack(spacing: 0) {
                    ForEach(0..<raws, id: \.self) { raw in
                        let index = column * raws + raw
                        if index < symbols.count {
                            TableCell(symbol: symbols[index])
                                .frame(minWidth: 50, maxWidth: 70, minHeight: 50, maxHeight: 70)
                        } else {
                            TableCell(symbol: nil)
                                .frame(minWidth: 50, maxWidth: 70, minHeight: 50, maxHeight: 70)
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    let symbols: [Symbol] = [
        .checkmark, .cross, .intermediate,
        .intermediate, .checkmark, .cross,
        .cross, .intermediate, .checkmark,
        .checkmark, .cross, .intermediate,
        .intermediate, .checkmark, .cross,
        .checkmark, .cross, .intermediate,
        .intermediate
    ]
    return RatingTable(symbols: symbols, title: "Урок 1")
}
