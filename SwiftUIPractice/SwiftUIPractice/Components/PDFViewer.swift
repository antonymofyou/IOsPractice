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

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.displayMode = .singlePage
        pdfView.displayDirection = .vertical
        // Первоначально устанавливаем autoScales в true, для расчета правильного масштабирования
        pdfView.autoScales = true

        // Установка документа
        if let document = document {
            pdfView.document = document
            DispatchQueue.main.async {
                self.centerAndScalePDF(pdfView: pdfView)
            }
        }

        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        // обновляем документ и центрируем на экране
        uiView.document = document
        DispatchQueue.main.async {
            self.centerAndScalePDF(pdfView: uiView)
        }
    }

    private func centerAndScalePDF(pdfView: PDFView) {
        // Получаем данные о странице pdf для расчета положения
        guard let currentPage = pdfView.currentPage else { return }
        let pageRect = currentPage.bounds(for: .mediaBox)
        let pdfBounds = pdfView.bounds

        // Расчет масштаба для вписывания страницы по ширине или высоте
        let scaleWidth = pdfBounds.width / pageRect.width
        let scaleHeight = pdfBounds.height / pageRect.height
        let scaleFactor = min(scaleWidth, scaleHeight)

        pdfView.scaleFactor = scaleFactor
        pdfView.minScaleFactor = scaleFactor / 2  // Минимальный масштаб
        pdfView.maxScaleFactor = scaleFactor * 3  // Максимальный масштаб

        // Центрирование страницы
        let scaledPageSize = CGSize(width: pageRect.width * scaleFactor, height: pageRect.height * scaleFactor)
        let horizontalPadding = max(0, (pdfBounds.width - scaledPageSize.width) / 2)
        let verticalPadding = max(0, (pdfBounds.height - scaledPageSize.height) / 2)

        // Обновление отступов для центрирования
        pdfView.layoutMargins = UIEdgeInsets(
            top: verticalPadding,
            left: horizontalPadding,
            bottom: verticalPadding,
            right: horizontalPadding
        )

        // Переключаем autoScales в false, чтобы пользователь мог масштабировать PDF
        pdfView.autoScales = false
    }
}

struct PDFViewer: View {
    // pdf документ для отображения, присваивается через Combine
    @State private var document: PDFDocument?
    @State private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    var documentURL: String

    var body: some View {
        VStack {
            if document != nil {
                PDFKitView(document: $document)
                    .edgesIgnoringSafeArea(.all)
            } else {
                Text("Загрузка...")
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
        PDFViewer(documentURL: "https://s549sas.storage.yandex.net/rdisk/06c4f69ff0edca3a1f13c5af34edee921add5b57edadabfbefaf64f7815515c9/667563f7/LJd5h2Yt4sQeIIdfa80A2erkgEtOcEIRgAJYk5egY45wd1TN5fzh7WnVvP6FvPC32g6i2ymbEomo8KLEfj5Jmg==?uid=545285032&filename=Резюме2.pdf&disposition=attachment&hash=&limit=0&content_type=application%2Fpdf&owner_uid=545285032&fsize=190100&hid=e5092f232b9bbaba8aefc786254c877d&media_type=document&tknv=v2&etag=774aec1e89869b54b46f5a78d0e45317&ts=61b64bc97abc0&s=0afb60a972aee9c153270c506c41bccc4ab3d5766c94044c9c8b0ed94e0a45bb&pb=U2FsdGVkX1-WF0si_SEZI464L13BFFWAEOumiXWDlSIM_D4rSDAW3fjPm5csJEdNeKh8Kb7EpqSKmcRLrRx9riRRPr_raow1wVgE_032XYk")
    }
}
