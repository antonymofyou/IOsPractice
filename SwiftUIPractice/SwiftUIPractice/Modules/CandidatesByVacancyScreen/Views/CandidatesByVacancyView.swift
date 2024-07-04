//
//  CandidatesByVacancyView.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 02.07.2024.
//

import SwiftUI

struct CandidatesByVacancyView: View {
    @StateObject var viewModel: CandidatesByVacancyViewModel = CandidatesByVacancyViewModel()
    var vacancies: [[String: String]]
    var currentVacancy: [String: String]

    var body: some View {
        VStack {
            switch viewModel.candidatesVacancyState {
            case .loading:
                ProgressView()
                    .scaleEffect(1.5)
                    .padding()

            case .success:
                CandidatesByVacancyContentView(selectedVacancyName: "\(currentVacancy["name"] ?? "")(id: \(currentVacancy["id"] ?? ""))", currentVacancy: currentVacancy, vacancies: vacancies).environmentObject(viewModel)
            }
        }
        .onAppear {
            viewModel.candidatesVacancyState = .loading
            viewModel.obtainData(id: currentVacancy["id"] ?? "")
        }
    }
}

#Preview {
    var vacancies: [[String: String]] = []
    var currentVacancy: [String: String] = [
        "published": "1",
        "name": "Менеджер вакансии 22",
        "description": "Описание вакансии",
        "createdAt": "2023-11-26 15:07:08",
        "id": "64"
    ]
    return CandidatesByVacancyView(vacancies: vacancies, currentVacancy: currentVacancy)
}
