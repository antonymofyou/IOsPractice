//
//  VacanciesViewModel.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 10.06.2024.
//

import SwiftUI

class VacanciesViewModel: ObservableObject {

    @Published var vacancies: [VacancyModel] = [] //Массив словарей вакансий
    var vacancyStatus: VacancyDownloadingState = .SUCCESS //Статус получения данных

}

enum VacancyDownloadingState {
    case LOADING, LOADED, SUCCESS
}
