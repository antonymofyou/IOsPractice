import SwiftUI

// MARK: - ImageWrapperView
struct ImageWrapperView: View {
    // `imageFrame` - фрейм изображения, который будет использоваться для создания области исключения в тексте.
    @State private var imageFrame: CGRect = .zero

    // `textContent` - текст, который будет отображаться в WrappedTextView.
    let textContent: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo hello world world world world world world world consequat."

    // Основное тело `ImageWrapperView`.
    var body: some View {
        ZStack {
            // Создает `WrappedTextView` и использует `imageFrame` как исключенную область.
            WrappedTextView(
                wrappedFrame: imageFrame,
                textContent: textContent)
                .frame(width: .infinity, height: .infinity) // Растягиваем на всю доступную область.

            // Использует `GeometryReader` для определения размеров родительского представления.
            GeometryReader { fullGeometry in
                Image(systemName: "app")
                    .resizable() // Делает изображение масштабируемым.
                    .frame(width: 120, height: 120) // Устанавливает фиксированный размер изображения.
                    .background(GeometryReader { imgGeometry in
                        Color.clear
                            .onAppear {
                                // Рассчитываем глобальный фрейм изображения для использования в качестве области исключения.
                                let imgFrame = imgGeometry.frame(in: .global)
                                // Перезапись фрейма для области исключения.
                                imageFrame = CGRect(
                                    x: fullGeometry.size.width - imgFrame.width - 10, // Позиция x, чтобы изображение было в правом верхнем углу. Параметр `-10` указывает отступ слева от картинки.
                                    y: 0, // Позиция y в верху представления.
                                    width: imgFrame.width + 20, // Ширина изображения(области исключения). Параметр `+20` - сумма отступа слева и справа.
                                    height: imgFrame.height) // Высота изображения.
                            }
                    })
                    .position(x: fullGeometry.size.width - imageFrame.width / 2, y: imageFrame.height / 2) // Центрируем изображение в его фрейме.
            }
        }
    }
}


// MARK: - WrappedTextView
// `WrappedTextView` - это UIViewRepresentable, который позволяет использовать UITextView в SwiftUI.
struct WrappedTextView: UIViewRepresentable {
    // `wrappedFrame` - прямоугольник, который будет исключен из области текста.
    var wrappedFrame: CGRect
    // `textContent` - текст, который будет отображаться в UITextView.
    var textContent: String

    // Создает и конфигурирует UITextView для использования в SwiftUI.
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = false // UITextView не будет редактируемым.
        textView.text = textContent // Установка текста, переданного в структуру.
        textView.font = UIFont.systemFont(ofSize: 18) // Установка шрифта текста.
        return textView
    }

    // Обновляет существующий UITextView с новыми параметрами, когда SwiftUI обновляет представление.
    func updateUIView(_ uiView: UITextView, context: Context) {
        let exclusionPath = UIBezierPath(rect: wrappedFrame) // Создаем путь исключения по `wrappedFrame`.
        uiView.textContainer.exclusionPaths = [exclusionPath] // Назначаем путь исключения в контейнер текста.
    }
}

// MARK: - ImageWrapperView_Preview
// Предпросмотр для `ImageWrapperView`.
#Preview {
    ImageWrapperView()
}
