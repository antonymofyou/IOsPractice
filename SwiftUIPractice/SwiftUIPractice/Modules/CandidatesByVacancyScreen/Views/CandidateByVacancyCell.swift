//
//  CandidateByVacancyCell.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 02.07.2024.
//

import SwiftUI


struct CandidateByVacancyCell: View {
    @Binding var candidate: [String: String]
    @Binding var vacancy: [String: String]
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("ФИО: \(candidate["fio"] ?? "")")
                Text("Дата отклика: \(candidate["createdAt"] ?? "")")
                Text("Статус отклика: \(candidate["status"] != "" ? candidate["status"] ?? "Неизвестный статус" : "Неизвестный статус")")
            }

            HStack {
                Spacer()
                Text("id: \(candidate["candidateId"] ?? "")")
                NavigationLink(destination: OtklikDetailView(vacancy: vacancy, otklikId: candidate["otklikId"] ?? "", candidateId: candidate["candidateId"] ?? "")) {
                    Image(systemName: "play.fill")
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                        .background(Color.blue)
                        .cornerRadius(5)
                }
                Spacer()
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

#Preview {
    let candidate: [String: String] = ["fio": "Иванов Иван", "createdAt": "2023-11-26 15:07:08", "status": "Анкета", "candidateId": "12345", "otklikId": "12345"]
    let vacancy: [String: String] = ["name": "Менеджер вакансии", "id": "64"]

    return CandidateByVacancyCell(candidate: .constant(candidate), vacancy: .constant(vacancy))
}
