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
                    ForEach($viewModel.candidates, id: \.self) { candidate in
                        CandidateByVacancyCell(candidate: candidate, vacancy: $currentVacancy)
                            .padding(.horizontal, 30)
                    }
                }
            }
        }
    }
}

#Preview {
   var viewModel: CandidatesByVacancyViewModel = CandidatesByVacancyViewModel()
    var vacancies: [[String: String]] = [["id": "64", "createdAt": "2023-11-26 15:07:08", "description": "описание вакансии", "published": "1", "name": "Менеджер вакансии 22"], ["id": "65", "createdAt": "2023-11-26 15:07:08", "description": "описание вакансии", "published": "1", "name": "Менеджер вакансии 23"]]
    var currentVacancy: [String: String] = [
        "published": "1",
        "name": "Менеджер вакансии 22",
        "description": "Описание вакансии",
        "createdAt": "2023-11-26 15:07:08",
        "id": "64"
    ]
    viewModel.obtainData(id: "64")
    return CandidatesByVacancyContentView(selectedVacancyName: "Менеджер вакансии 22(id: 64)", currentVacancy: currentVacancy, vacancies: vacancies).environmentObject(viewModel)
}
