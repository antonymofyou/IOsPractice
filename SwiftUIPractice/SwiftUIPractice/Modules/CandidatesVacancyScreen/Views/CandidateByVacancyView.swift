//
//  CandidateDetailScreen.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 29.06.2024.
//

import SwiftUI

struct CandidateByVacancyView: View {

    @StateObject var viewModel = CandidatesVacancyViewModel()

    @State private var isStatusOpen = false
    @State private var selectedStatus = "анкета"
    @State private var statusOptions = ["анкета", "1", "2", "3"]

    @State private var isVacancyOpen = false
    @State private var selectedVacancy = "Название вакансии"
    @State private var vacancyOptions = ["Название вакансии", "1", "2", "3"]

    @State private var isCandidateAnswersOpen = false
    @State private var isCandidateCommentsOpen = false
    @State private var newComment = ""

    var body: some View {

        switch viewModel.candidatesStatus {
        case .loading:
            ProgressView()
                .scaleEffect(1.5)
                .padding()

        case .success:
            ScrollView {
                VStack(spacing: 20) {
                    Text("Отклик на вакансию")
                    // 1. Статус отклика
                    blockView {
                        HStack {

                            Text("Статус отклика")
                                .padding()
                            Menu {
                                ForEach(statusOptions, id: \.self) { option in
                                    Button(action: {
                                        selectedStatus = option
                                    }) {
                                        Text(option)
                                    }
                                }
                            } label: {
                                Text(selectedStatus)
                                    .padding()
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                            }

                            Button(action: {}) {
                                Text("Изменить")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }

                    }

                    // 2. Название вакансии
                    blockView {
                        HStack {
                            Text(selectedVacancy)
                            Spacer()
                            Button(action: {
                                isVacancyOpen.toggle()
                            }) {
                                Image(systemName: isVacancyOpen ? "chevron.up" : "chevron.down")
                            }
                        }
                        if isVacancyOpen {
                            ForEach(vacancyOptions, id: \.self) { option in
                                Button(action: {
                                    selectedVacancy = option
                                    isVacancyOpen = false
                                }) {
                                    Text(option)
                                        .padding()
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(10)
                                }
                            }
                        }
                    }

                    // 3. Кандидат
                    blockView {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Кандидат")
                            HStack {
                                Text("ФИО: \(viewModel.candidates["fio"] ?? "")")
                            }
                            HStack {
                                Text("Телеграмм: @\(viewModel.candidates["tgNickname"] ?? "")")
                            }
                        }
                    }

                    // 4. Ответы кандидата
                    blockView {
                        HStack {
                            Text("Ответы кандидата")
                            Spacer()
                            Button(action: {
                                isCandidateAnswersOpen.toggle()
                            }) {
                                Image(systemName: isCandidateAnswersOpen ? "chevron.up" : "chevron.down")
                            }
                        }
                        if isCandidateAnswersOpen {
                            ForEach(["1", "2", "3"], id: \.self) { answer in
                                Text(answer)
                                    .padding()
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                            }
                        }
                    }

                    // 5. Комментарии на отклик кандидата
                    blockView {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Комментарии на отклик кандидата")
                            if true { // Add condition for empty comments
                                Text("Нет комментариев")
                                    .padding()
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                            }
                            Text("Создать комментарий")
                            TextField("Введите текст", text: $newComment)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            HStack {
                                Spacer()
                                Button(action: {}) {
                                    Text("Добавить комментарий")
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                            }
                        }
                    }

                    // 6. Комментарии на кандидата
                    blockView {
                        HStack {
                            Text("Комментарии на кандидата")
                            Spacer()
                            Button(action: {
                                isCandidateCommentsOpen.toggle()
                            }) {
                                Image(systemName: isCandidateCommentsOpen ? "chevron.up" : "chevron.down")
                            }
                        }
                        if isCandidateCommentsOpen {
                            ForEach(["Комментарий 1", "Комментарий 2", "Комментарий 3"], id: \.self) { comment in
                                Text(comment)
                                    .padding()
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
                .padding()
            }
        }
    }
}

@ViewBuilder
func blockView<Content: View>(@ViewBuilder content: () -> Content) -> some View {
    VStack(alignment: .leading, spacing: 10, content: content)
        .frame(maxWidth: .infinity)
        .padding()
        .background(RoundedRectangle(cornerRadius: 10)
            .stroke(Color.blue, lineWidth: 2))
}

#Preview {
    CandidateByVacancyView()
}
