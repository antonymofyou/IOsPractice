//
//  TopView.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 04.07.2024.
//

import SwiftUI

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

#Preview {
    TopView().environmentObject(VacanciesViewModel())
}
