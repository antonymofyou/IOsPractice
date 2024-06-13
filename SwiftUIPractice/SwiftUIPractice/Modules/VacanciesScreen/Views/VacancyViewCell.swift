//
//  VacancyViewCell.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 13.06.2024.
//

import SwiftUI

struct VacancyCellView: View {

    var vacancy: [String: String]

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text("id: \(vacancy["id"] ?? "")")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding([.top, .trailing], 10)

            Text(vacancy["name"] ?? "")
                .font(.headline)
                .fontWeight(.bold)
                .padding([.leading, .bottom], 10)

            Text(vacancy["description"] ?? "")
                .font(.subheadline)
                .padding([.leading, .bottom], 10)

            Text((vacancy["published"] == "0") ? "Не опубликована" : "Опубликована")
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor((vacancy["published"] == "0") ? .red : .green)
                .padding([.leading, .bottom], 10)

            HStack {
                Button(action: {
                    print("открывается экран откликов")
                }) {
                    Text("Отклики")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                }
                .cornerRadius(10)
                Spacer()
                Button(action: {
                    print("открывается экран редактирования")
                }) {
                    Text("Редактировать")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                }
                .cornerRadius(10)
            }
            .padding([.leading, .trailing, .bottom], 10)
        }
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
        .padding([.leading, .trailing, .top], 10)
    }
}

#Preview {
    VacancyCellView(vacancy: ["id": "1", "name": "Front", "description": "Описание вакансии", "published": "1", "createdAt": "2023-06-01"])
}

