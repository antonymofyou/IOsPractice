//
//  CommentView.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 04.07.2024.
//

import SwiftUI

struct CommentView: View {
    let name: String
    let text: String
    let date: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(name)
                .font(.headline)
                .fontWeight(.bold)

            Text(text)
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)

            HStack {
                Spacer()
                Text(date)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
    }
}


#Preview {
    CommentView(name: "Иван иванов", text: "Текст комментария", date: "13-04-2024")
}
