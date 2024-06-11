import SwiftUI

// MARK: - ImageWrapperView
struct ImageWrapperView: View {
    // `imageFrame` - фрейм изображения, который будет использоваться для создания области исключения в тексте.
    @State private var imageFrame: CGRect = .zero
    // `textContent` - текст, который будет отображаться в WrappedTextView.
    var textContent: String
    // `imageContent` - изображение, которая будет отображаться в Image.
    var imageContent: UIImage
    // `maxWidth` - максимальная ширина картинки.
    var maxWidth: CGFloat?
    // `maxHeight` - максимальная высота картинки.
    var maxHeight: CGFloat?
    // `fontSize` - размер шрифта в тексте.
    var fontSize: CGFloat
    // Основное тело `ImageWrapperView`.
    var body: some View {
        ZStack {
            // Создает `WrappedTextView` и использует `imageFrame` как исключенную область.
            WrappedTextView(
                fontSize: fontSize,
                wrappedFrame: imageFrame,
                textContent: textContent
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Растягиваем на всю доступную область.

            // Использует `GeometryReader` для определения размеров родительского представления.
            GeometryReader { fullGeometry in
                // `coefficient` - коэффициент, рассчитываемый для изменения размера изображения, основываясь на maxWidth, maxHeight и размера imageContent
                let coefficient = imageContent.size.width >= imageContent.size.height ? (maxWidth ?? 140) / imageContent.size.width : (maxHeight ?? 140) / imageContent.size.height
                // `calculatedWidth` - финальная широта изображения на экране.
                let calculatedWidth = imageContent.size.width * coefficient
                // `calculatedHeight` - финальная высота изображения на экране.
                let calculatedHeight = imageContent.size.height * coefficient

                Image(uiImage: imageContent)
                    .resizable() // Делает изображение масштабируемым.
                    .background(
                        GeometryReader { imageGeometry in
                            Color.clear
                                .onAppear {
                                    // Рассчитывает глобальный фрейм изображения для использования в качестве области исключения.
                                    let imgFrame = imageGeometry.frame(in: .global)
                                    // Перезапись фрейма для области исключения.
                                    imageFrame = CGRect(
                                        x: fullGeometry.size.width - imgFrame.width - 10, // Позиция x, чтобы изображение было в правом верхнем углу. Параметр `-10` указывает
                                        y: 0, // Позиция y в верху представления.
                                        width: imgFrame.width + 20, // Ширина изображения(области исключения). Параметр `+20` - сумма отступа слева и справа.
                                        height: imgFrame.height // Высота изображения.
                                    )
                                }
                        }
                    )
                    .frame(width: calculatedWidth, height: calculatedHeight) // Устанавливает размер изображения.
                    .position(
                        x: fullGeometry.size.width - (calculatedWidth / 2) - 10,
                        y: calculatedHeight / 2
                    )  // Центрируем изображение в его фрейме.
            }
        }
    }
}

// MARK: - WrappedTextView
// `WrappedTextView` - это UIViewRepresentable, который позволяет использовать UITextView в SwiftUI.
struct WrappedTextView: UIViewRepresentable {
    // `fontSize` - размер шрифта для текста, который будет отображаться в UITextView.
    var fontSize: CGFloat
    // `wrappedFrame` - прямоугольник, который будет исключен из области текста.
    var wrappedFrame: CGRect
    // `textContent` - текст, который будет отображаться в UITextView.
    var textContent: String

    // Создает и конфигурирует UITextView для использования в SwiftUI.
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = false // UITextView не будет редактируемым.
        textView.text = textContent // Установка текста, переданного в структуру.
        textView.font = UIFont.systemFont(ofSize: fontSize) // Установка шрифта текста.
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
    ImageWrapperView(
        textContent: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
        imageContent: .remove,
        fontSize: 18
    )
}
