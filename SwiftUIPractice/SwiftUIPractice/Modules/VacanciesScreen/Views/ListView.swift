//
//  ListView.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 04.07.2024.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var viewModel: VacanciesViewModel

    var body: some View {
        ScrollView {
            VStack {
                ForEach(0..<viewModel.vacancies.count) { index in
                    VacancyCellView(vacancies: viewModel.vacancies, vacancy: viewModel.vacancies[index])
                }
            }
        }
    }
}

#Preview {
    let viewModel = VacanciesViewModel(isPreview: true)
    viewModel.vacancyStatus = .success
    viewModel.vacancies = [ ["id": "1", "name": "Front", "description": "Описание вакансии", "published": "1", "createdAt": "2023-06-01"], ["id": "2", "name": "Data Scientist", "description": "Описание вакансии", "published": "1", "createdAt": "2023-06-02"], ["id": "3", "name": "Project Manager", "description": "Описание вакансии", "published": "0", "createdAt": "2023-06-03"], ["id": "4", "name": "Project Manager", "description": "Описание вакансии", "published": "0", "createdAt": "2023-06-03"]]
    return ListView().environmentObject(viewModel)
}

