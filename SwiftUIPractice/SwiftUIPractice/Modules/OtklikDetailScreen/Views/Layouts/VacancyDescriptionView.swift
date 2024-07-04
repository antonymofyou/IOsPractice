//
//  VacancyDescriptionView.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 04.07.2024.
//

import SwiftUI

struct VacancyDescriptionView: View {
    @State var isExpanded: Bool = false
    var vacancy: [String: String]

    var body: some View {
        ExpandableBlockView(
            title: vacancy["name"] ?? "Отсутствует имя вакансии",
            content: {
                Text(vacancy["description"] ?? "Отсутствует описание")
            },
            isExpanded: $isExpanded
        )
    }
}

#Preview {
    VacancyDescriptionView(vacancy: ["name": "Тестировщик", "description": "Описание вакансии"])
}

