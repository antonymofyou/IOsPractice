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
    var onCellTapped: (Int) -> Void

    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .padding()

            Grid(symbols: symbols, rows: determineColumns(count: symbols.count), onCellTapped: onCellTapped)
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

struct RatingTableCell: View {
    let symbol: Symbol?
    let index: Int
    let onCellTapped: (Int) -> Void

    var body: some View {
        ZStack {
            Rectangle()
                .stroke(Color.black, lineWidth: 1)
            if let symbol = symbol {
                SymbolView(symbol: symbol)
                    .padding(10)
            }
        }
        .onTapGesture {
            onCellTapped(index)
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
    let rows: Int
    let onCellTapped: (Int) -> Void

    var body: some View {
        let columns = (symbols.count + rows - 1) / rows

        VStack(spacing: 0) {
            ForEach(0..<columns, id: \.self) { column in
                HStack(spacing: 0) {
                    ForEach(0..<rows, id: \.self) { row in
                        let index = column * rows + row
                        if index < symbols.count {
                            RatingTableCell(symbol: symbols[index], index: index, onCellTapped: onCellTapped)
                                .frame(width: 60, height: 60)
                        } else {
                            Spacer()
                                .frame(width: 60, height: 60)
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
    return RatingTable(symbols: symbols, title: "Урок 1", onCellTapped: { index in
        print("Cell tapped: \(index)")
    })
}
