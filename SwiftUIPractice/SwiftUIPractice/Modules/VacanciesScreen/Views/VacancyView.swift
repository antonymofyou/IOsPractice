//
//  VacancyView.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 13.06.2024.
//

import SwiftUI

struct VacancyView: View {
    @StateObject var viewModel = VacanciesViewModel()

    var body: some View {
        switch viewModel.vacancyStatus {
        case .loading:
            ProgressView()
                .scaleEffect(1.5)
                .padding()

        case .success:
            VStack {
                TopView().environmentObject(viewModel)
                ListView().environmentObject(viewModel)
            }
            .padding()
        }
    }
}

#Preview {
    let viewModel = VacanciesViewModel(isPreview: true)
    viewModel.vacancyStatus = .success
    viewModel.vacancies = [ ["id": "1", "name": "Front", "description": "Описание вакансии", "published": "1", "createdAt": "2023-06-01"], ["id": "2", "name": "Data Scientist", "description": "Описание вакансии", "published": "1", "createdAt": "2023-06-02"], ["id": "3", "name": "Project Manager", "description": "Описание вакансии", "published": "0", "createdAt": "2023-06-03"], ["id": "4", "name": "Project Manager", "description": "Описание вакансии", "published": "0", "createdAt": "2023-06-03"]]

    let view =  VacancyView(viewModel: viewModel)

    return view
}
