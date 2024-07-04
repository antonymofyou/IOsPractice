//
//  OtklikStatusView.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 04.07.2024.
//

import SwiftUI

struct OtklikStatusView: View {
    @EnvironmentObject var viewModel: OtklikDetailViewModel
    @State private var selectedStatus = "Неизвестный статус"

    var body: some View {
        blockView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Статус отклика: ")
                    Spacer()
                    Menu {
                        ForEach(viewModel.statusTransfers, id: \.self) { option in
                            Button(action: {
                                selectedStatus = option
                            }) {
                                Text(option)
                            }
                        }
                    } label: {
                        HStack {
                            Text(selectedStatus)
                            Image(systemName: "chevron.down")
                                .font(.caption)
                        }
                        .foregroundColor(.primary)
                    }
                    .onAppear {
                        selectedStatus = ((viewModel.otklikInfo["status"] != "" ? viewModel.otklikInfo["status"] : "Неизвестный статус") ?? "Неизвестный статус")
                    }
                }.padding(.vertical)

                BlueButton(title: "Изменить") {
                    viewModel.setStatus(toStatusName: selectedStatus)
                }
            }
        }
    }
}

#Preview {
    var viewModel = OtklikDetailViewModel(id: "64", otklikId: "34", candidateId: "5")
    return OtklikStatusView()
        .environmentObject(viewModel)
}


