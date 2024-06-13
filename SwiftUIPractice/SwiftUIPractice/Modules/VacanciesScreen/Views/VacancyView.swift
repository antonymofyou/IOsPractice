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

struct TopView: View {
    @EnvironmentObject var viewModel: VacanciesViewModel

    var body: some View {
        HStack {
            Spacer()
            Text("Вакансии")
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .center)
            Spacer()
            Button(action: {
                print("открывается экран добавления новой вакансии")
            }) {
                Text("+")
                    .font(.title)
                    .foregroundColor(.black)
                    .frame(width: 40, height: 40)
                    .background(Color.gray)
                    .opacity(0.4)
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
            }
            Spacer()
        }
        .padding()
    }
}

struct ListView: View {
    @EnvironmentObject var viewModel: VacanciesViewModel

    var body: some View {
        ScrollView {
            VStack {
                ForEach(0..<viewModel.vacancies.count) { index in
                    VacancyCellView(vacancy: viewModel.vacancies[index])
                }
            }
        }
    }
}

#Preview {
    return VacancyView()
}

