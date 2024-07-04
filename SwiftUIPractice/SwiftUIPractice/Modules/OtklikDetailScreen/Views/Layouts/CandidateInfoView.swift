//
//  CandidateInfoView.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 04.07.2024.
//

import SwiftUI

struct CandidateInfoView: View {
    @EnvironmentObject var viewModel: OtklikDetailViewModel

    var body: some View {
        blockView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Кандидат")
                HStack {
                    Text("ФИО:  \(viewModel.otklikInfo["fio"] ?? "")")
                }
                HStack {
                    Text("Телеграмм:")
                    if let tgNickname = viewModel.otklikInfo["tgNickname"],
                       !tgNickname.isEmpty,
                        let url = URL(string: "https://t.me/\(tgNickname)") {
                        Link("@\(tgNickname)", destination: url)
                            .foregroundColor(.blue)
                    } else {
                        Text("Не указан")
                    }
                }
            }
        }
    }
}

#Preview {
    var viewModel: OtklikDetailViewModel = OtklikDetailViewModel(id: "64", otklikId: "34", candidateId: "5")
    return CandidateInfoView().environmentObject(viewModel)
}

