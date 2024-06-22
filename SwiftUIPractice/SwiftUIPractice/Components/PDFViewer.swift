//
//  PDFView.swift
//  SwiftUIPractice
//
//  Created by Кирилл Щёлоков on 21.06.2024.
//

import SwiftUI
import PDFKit
import Combine

// Используем UIViewRepresentable так как внутренняя библиотека PDFKit используется с UIKit
struct PDFKitView: UIViewRepresentable {
    @Binding var document: PDFDocument?
    @Binding var currentPageIndex: Int

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.displayMode = .singlePage
        pdfView.displayDirection = .vertical
        // Первоначально устанавливаем autoScales в true, для расчета правильного масштабирования
        pdfView.autoScales = true

        // Установка документа
        if let document = document {
            pdfView.document = document
        }

        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        // обновляем документ и центрируем на экране
        if let document = document {
            uiView.document = document
            //переход по страницам с текущим индексом
            if let page = document.page(at: currentPageIndex) {
                uiView.go(to: page)
            }
        }
    }
}

struct PDFViewer: View {
    // pdf документ для отображения, присваивается через Combine
    @State private var document: PDFDocument?
    @State private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    var documentURL: String

    @State private var currentPageIndex: Int = 0

    var body: some View {
        VStack {
            if let document = document {
                VStack {
                    PDFKitView(document: $document, currentPageIndex: $currentPageIndex)
                        .edgesIgnoringSafeArea(.all)

                    HStack {
                        Spacer()
                        Button(action: {
                            //переход к предыдущему слайду
                            if currentPageIndex > 0 {
                                currentPageIndex -= 1
                            }
                        }) {
                            Image(systemName: "arrow.left")
                        }
                        .padding()
                        Spacer()
                        Button(action: {
                            //переход к следующему слайду
                            if currentPageIndex < (document.pageCount - 1) {
                                currentPageIndex += 1
                            }
                        }) {
                            Image(systemName: "arrow.right")
                        }
                        .padding()
                        Spacer()
                    }
                }
            } else {
                Text("Loading...")
                    .onAppear {
                        loadPDF()
                    }
            }
        }
    }

    private func loadPDF() {
        // загружаем pdf
        guard let url = URL(string: documentURL) else { return }
        // используем Combine для подгрузки и отслеживания изменений
        URLSession.shared.dataTaskPublisher(for: url)
            .map { PDFDocument(data: $0.data) }
            .replaceError(with: nil)  // если ошибка при загрузке - возвращаем nil для отказоустойчивости приложения
            .receive(on: DispatchQueue.main) // получаем в главном потоке, так как надо отрисовывать UI
            .assign(to: \.document, on: self) // сохраняем результат в переменную document
            .store(in: &cancellable)
    }
}

struct PDFViewer_Previews: PreviewProvider {
    static var previews: some View {
        PDFViewer(documentURL: "https://s956sas.storage.yandex.net/rdisk/b900b5c02760cb5c04f26fd5b492b753ec5cd677604b711e2ef48a697516f25d/6676e7e0/LJd5h2Yt4sQeIIdfa80A2RDUqte3sOqEfQt1maKeZP8hbk-NWSu2IOwqCzW26ayx80NBfPrQTboqPnDv683_mA==?uid=545285032&filename=test2.pdf&disposition=attachment&hash=&limit=0&content_type=application%2Fpdf&owner_uid=545285032&fsize=10767270&hid=1d8673e0f2400f453174241a9c187988&media_type=document&tknv=v2&etag=c7a86ec848f3f30cd076aa436bcab053&ts=61b7bdba1b800&s=6b267cc7c32042136e98512536c012b63dc5b0c326647050c78ea304430a2e56&pb=U2FsdGVkX1_bgdVSDF493ET92m6kXO05o2AVuk3QLqgqUoGTARJYo5TIzEmCEWbEpLsieykqBXj3U2eqgob77kRX_AtBdEvuEaQ9avAhexw")added the ability to scroll through slides
    }
}
