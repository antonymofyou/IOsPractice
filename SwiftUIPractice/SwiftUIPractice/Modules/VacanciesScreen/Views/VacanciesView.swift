//
//  VacanciesView.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 10.06.2024.
//

import SwiftUI

struct VacanciesView: View {
    @StateObject private var viewModel = VacanciesViewModel()

    var body: some View {
        VStack {
            TopView().environmentObject(viewModel)
            ListView().environmentObject(viewModel)
        }
        .padding()
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

struct VacancyCellView: View {
    var vacancy: VacancyModel

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text("id: \(vacancy.info["id"] as? Int ?? 0)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding([.top, .trailing], 10)

            Text(vacancy.info["name"] as? String ?? "")
                .font(.headline)
                .fontWeight(.bold)
                .padding([.leading, .bottom], 10)

            Text(vacancy.info["description"] as? String ?? "")
                .font(.subheadline)
                .padding([.leading, .bottom], 10)

            Text((vacancy.info["published"] as? Int == 0) ? "Не опубликована" : "Опубликована")
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor((vacancy.info["published"] as? Int == 0) ? .red : .green)
                .padding([.leading, .bottom], 10)

            HStack {
                Button(action: {
                    print("открывается экран откликов")
                }) {
                    Text("Отклики")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                }
                .cornerRadius(10)
                Spacer()
                Button(action: {
                    print("открывается экран редактирования")
                }) {
                    Text("Редактировать")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                }
                .cornerRadius(10)
            }
            .padding([.leading, .trailing, .bottom], 10)
        }
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
        .padding([.leading, .trailing, .top], 10)
    }
}

#Preview {
    ContentView()
}
