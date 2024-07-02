//
//  CandidatesByVacancyContentView.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 02.07.2024.
//

import SwiftUI

struct CandidatesByVacancyContentView: View {
    @State var selectedVacancyName: String
    @State private var selectedStatus = "Все"
    @State var currentVacancy: [String: String]
    @EnvironmentObject var viewModel: CandidatesByVacancyViewModel
    var vacancies: [[String: String]]
    var body: some View {
        VStack {
            Text("Кандидаты Вакансии")
                .font(.title)
                .padding()

            HStack {
                Text("Вакансия:")
                Menu {
                    ForEach(vacancies, id: \.self) { vacancy in
                        Button("\(vacancy["name"] ?? "")(id: \(vacancy["id"] ?? ""))", action: {
                            selectedVacancyName = "\(vacancy["name"] ?? "")(id: \(vacancy["id"] ?? ""))"
                            currentVacancy = vacancy
                            viewModel.obtainData(id: vacancy["id"] ?? "")
                        })
                    }
                } label: {
                    Text(selectedVacancyName)
                    Image(systemName: "chevron.down")
                }
            }

            HStack {
                Text("Статус:")
                Menu {
                    Button("Все", action: {
                        selectedStatus = "Все"
                    })
                } label: {
                    Text(selectedStatus)
                    Image(systemName: "chevron.down")
                }
            }

            Text(selectedVacancyName)
                .font(.headline)
                .padding()

            ScrollView {
                VStack(spacing: 10) {
                    ForEach(viewModel.candidates, id: \.self) { candidate in
                        CandidateByVacancyCell(candidate: candidate, vacancy: currentVacancy)
                            .padding(.horizontal, 30)
                    }
                }
            }
        }
    }
}

#Preview {
    CandidatesByVacancyContentView(selectedVacancyName: "", currentVacancy: [:], vacancies: [])
}
