//
//  CandidateByVacancyCell.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 02.07.2024.
//

import SwiftUI

import SwiftUI

struct CandidateByVacancyCell: View {
    @Binding var candidate: [String: String]
    @Binding var vacancy: [String: String]
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("ФИО: \(candidate["fio"] ?? "")")
                Text("Дата отклика: \(candidate["createdAt"] ?? "")")
                Text("Статус отклика: \(candidate["status"] != "" ? candidate["status"]! : "Неизвестный статус")")
            }

            HStack {
                Spacer()
                Text("id: \(candidate["candidateId"] ?? "")")
//                NavigationLink(destination: OtklikDetailView(vacancy: vacancy, otklikId: candidate["otklikId"] ?? "", candidateId: candidate["candidateId"] ?? "")) {
//                    Image(systemName: "play.fill")
//                        .foregroundColor(.white)
//                        .frame(width: 30, height: 30)
//                        .background(Color.blue)
//                        .cornerRadius(5)
//                }
//                Spacer()
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

//TODO: сделать Preview
//#Preview {
//    CandidateByVacancyCell(candidate: [:], vacancy: [:])
//}
