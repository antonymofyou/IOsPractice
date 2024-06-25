//
//  PDFView.swift
//  SwiftUIPractice
//
//  Created by Кирилл Щёлоков on 21.06.2024.
//

import SwiftUI
import PDFKit
// Используем UIViewRepresentable так как внутренняя библиотека PDFKit используется с UIKit
struct PDFKitView: UIViewRepresentable {
    // PDF документ, который будет отображаться
    var document: PDFDocument
    // Связь с текущим индексом страницы для управления просмотром
    @Binding var currentPageIndex: Int

    // Создание и настройка PDFView
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.displayMode = .singlePage
        pdfView.displayDirection = .vertical
        pdfView.autoScales = true
        pdfView.document = document

        return pdfView
    }

    // Обновление отображаемого PDFView при изменении данных
    func updateUIView(_ uiView: PDFView, context: Context) {
        uiView.document = document
        if let page = document.page(at: currentPageIndex) {
            uiView.go(to: page)
        }
    }
}

struct PDFViewer: View {
    @State private var currentPageIndex: Int = 0
    // Данные PDF документа для отображения
    var documentData: Data

    var body: some View {
        VStack {
            if let document = PDFDocument(data: documentData) {
                VStack {
                    // Отображение PDFKitView с переданным документом и текущим индексом страницы
                    PDFKitView(document: document, currentPageIndex: $currentPageIndex)
                        .edgesIgnoringSafeArea(.all)

                    // Кнопки для перехода к предыдущей и следующей страницам
                    HStack {
                        Spacer()
                        Button(action: {
                            if currentPageIndex > 0 {
                                currentPageIndex -= 1
                            }
                        }) {
                            Image(systemName: "arrow.left")
                        }
                        .padding()

                        Spacer()

                        Button(action: {
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
                Text("Ошибка")
            }
        }
    }
}

struct PDFViewer_Previews: PreviewProvider {
    static var previews: some View {
        PDFViewer(documentData: generatePDF())
    }

    static func generatePDF() -> Data {
        // Создание метаданных для PDF
        let pdfMetaData = [
            kCGPDFContextCreator: "Your App",
            kCGPDFContextAuthor: "Your Name"
        ]

        // Создание формата рендеринга PDF с указанными метаданными
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]

        // Определение ширины и высоты страницы
        let pageWidth = 8.5 * 72.0
        let pageHeight = 11 * 72.0
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)

        // Создание рендерера PDF с указанным размером страницы и форматом
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)

        // Генерация данных PDF
        let data = renderer.pdfData { context in
            // Начало рендеринга первой страницы
            context.beginPage()

            // Добавление текста на первую страницу
            let text1 = "Это текст на первой странице PDF файла"
            let attributes1 = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24)
            ]
            text1.draw(at: CGPoint(x: 50, y: 50), withAttributes: attributes1)

            // Начало рендеринга второй страницы
            context.beginPage()

            // Добавление текста на вторую страницу
            let text2 = "Это текст на второй странице PDF файла"
            let attributes2 = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24)
            ]
            text2.draw(at: CGPoint(x: 50, y: 50), withAttributes: attributes2)
        }

        return data
    }
}
