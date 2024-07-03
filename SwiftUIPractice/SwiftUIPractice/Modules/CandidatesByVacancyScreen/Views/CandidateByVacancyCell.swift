//
//  CandidateByVacancyCell.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 02.07.2024.
//

import SwiftUI

struct CandidateByVacancyCell: View {
    var candidate: [String: String]
    var vacancy: [String: String]
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("ФИО: \(candidate["fio"] ?? "")")
                Text("Дата отклика: \(candidate["createdAt"] ?? "")")
                Text("Статус отклика: \(candidate["status"] != "" ? candidate["status"]! : "Неизвестный статус")")
            }

            HStack {
                Spacer()
                Text("id: \(candidate["otklikId"] ?? "")")
                Button(action: {
                    print(candidate)
                }) {
                    Image(systemName: "play.fill")
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                        .background(Color.blue)
                        .cornerRadius(5)
                }
                .background {
                    //TODO: раскомментировать после merge следущей ветки
//                    NavigationLink(destination: VacancyResponseView(vacancy: vacancy, otklikId: candidate["otklikId"] ?? "", candidateId: candidate["otklikId"] ?? "")) {
//                        EmptyView()
//                    }
//                    .buttonStyle(PlainButtonStyle())
//                    .opacity(0)
                }
                .buttonStyle(PlainButtonStyle())
                Spacer()
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

#Preview {
    CandidateByVacancyCell(candidate: [:], vacancy: [:])
}
