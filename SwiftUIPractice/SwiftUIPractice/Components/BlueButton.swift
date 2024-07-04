//
//  BlueButton.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 04.07.2024.
//

import SwiftUI

struct BlueButton: View {
    let title: String
    let action: () -> Void
    var backgroundColor: Color = .blue

    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding()
                .background(backgroundColor)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}

#Preview {
    BlueButton(title: "Сохранить", action: {
        print("нажатие на кнопку")
    })
}
