//
//  KnowledgeCheckView.swift
//  SwiftUIPractice
//
//  Created by Кирилл Щёлоков on 08.06.2024.
//

import SwiftUI

struct KnowledgeCheckView: View {
    @State private var startCoordinates = CGPoint(x: 0, y: 0)
    @State private var endCoordinates = CGPoint(x: 0, y: 0)
    @State var globalCoords = CGPoint(x: 0, y: 0)
    @State var squareCoords: [CGPoint] = [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 0)]
    @State private var showAlert = false

    let text = "Эти меры привели к значительным изменениям в экономике, обществе и культуре СССР. Однако, они также сопровождались значительными трудностями и трагедиями, включая репрессии, голод и насильственную коллективизацию, что оказало глубокое влияние на жизнь миллионов людей. Эти меры привели к значительным изменениям в экономике, обществе и культуре СССР. Однако, они также сопровождались значительными трудностями и трагедиями, включая репрессии, голод и насильственную коллективизацию, что оказало глубокое влияние на жизнь миллионов людей. Эти меры привели к значительным изменениям в экономике, обществе и культуре СССР. Однако, они также сопровождались значительными трудностями и трагедиями, включая репрессии, голод и насильственную коллективизацию, что оказало глубокое влияние на жизнь миллионов людей."
    let startIndex = 32
    let endIndex = 64

    var body: some View {
        if #available(iOS 15.0, *) {
            ScrollView {
                ZStack {
                    MainContentView(text: text, startIndex: startIndex, endIndex: endIndex, showAlert: $showAlert, startCoordinates: $startCoordinates, endCoordinates: $endCoordinates, globalCoords: $globalCoords, squareCoords: $squareCoords)
                    RectanglePathView(squareCoords: $squareCoords)
                    ArrowPathView(startCoordinates: $startCoordinates, endCoordinates: $endCoordinates)
                    if showAlert {
                        TeacherCommentPopUpView(numOfComment: "1", textOfComment: "Ошибка")
                            .position(midPoint)
                    }
                }
            }
            .background {
                GeometryReader { geom in
                    Color.clear.onAppear {
                        self.globalCoords = geom.frame(in: .global).origin
                    }
                }
            }
            //            .edgesIgnoringSafeArea(.bottom)
        } else {
            // Fallback on earlier versions
        }
    }

    var midPoint: CGPoint {
        CGPoint(x: (startCoordinates.x + endCoordinates.x) / 2, y: (startCoordinates.y + endCoordinates.y) / 2)
    }
}

struct MainContentView: View {
    let text: String
    let startIndex: Int
    let endIndex: Int
    @Binding var showAlert: Bool
    @Binding var startCoordinates: CGPoint
    @Binding var endCoordinates: CGPoint
    @Binding var globalCoords: CGPoint
    @Binding var squareCoords: [CGPoint]

    var body: some View {
        VStack {
            Spacer()
            if #available(iOS 15, *) {
                AttributedText(text: text, startIndex: startIndex, endIndex: endIndex, fontSize: 18, isZacherkn: true)
                    .background {
                        GeometryReader { geo in
                            Color.clear
                                .onAppear {
                                    self.startCoordinates = findWordCoordinates(in: geo, text: text, startIndex: startIndex, endIndex: endIndex, fontSize: 18)
                                }
                        }
                    }
            } else {
                // Fallback on earlier versions
            }

            Spacer().frame(height: 50)
            HStack {
                Text("Ком. 0:")
                    .bold()
                    .foregroundColor(.green)
                    .padding(.vertical, 10)
                    .padding(.leading, 10)
                Text("Ошибка")
                    .foregroundColor(.green)
                    .onTapGesture {
                        showAlert.toggle()
                    }
                Spacer()
            }
            .overlay(
                GeometryReader { geometry in
                    ZStack {
                        Color.clear
//                            .opacity(0.4)
                            .onAppear {
                                // Getting coordinates in global coordinate system
                                let globalCoordinates = geometry.frame(in: .global).origin
                                self.endCoordinates = CGPoint(x: globalCoordinates.x + (geometry.size.width) / 2, y: globalCoordinates.y - globalCoords.y)
                            }
                        RoundedRectangle(cornerRadius: 5, style: .circular)
                            .stroke(Color.purple, lineWidth: 2)
                    }
                }
            )
            Spacer()
        }
        //        .edgesIgnoringSafeArea(.all)
    }

    func findWordCoordinates(in geo: GeometryProxy, text: String, startIndex: Int, endIndex: Int, fontSize: CGFloat) -> CGPoint {
        let range = NSRange(location: startIndex, length: endIndex - startIndex)

        // Create an attributed string to measure the positions
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]
        let attributedString = NSAttributedString(string: text, attributes: attributes)

        // Create a text storage and layout manager to calculate the positions
        let textStorage = NSTextStorage(attributedString: attributedString)
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: geo.size)
        textContainer.lineFragmentPadding = 0
        textStorage.addLayoutManager(layoutManager)
        layoutManager.addTextContainer(textContainer)

        // Get the bounding rect of the word
        let glyphRange = layoutManager.glyphRange(forCharacterRange: range, actualCharacterRange: nil)
        let boundingRect = layoutManager.boundingRect(forGlyphRange: glyphRange, in: textContainer)

        // Convert the bounding rect to global coordinates
        let globalOrigin = geo.frame(in: .global).origin
        let minX = boundingRect.minX
        let minY = boundingRect.minY + globalOrigin.y - globalCoords.y
        let maxX = boundingRect.maxX
        let maxY = boundingRect.maxY + globalOrigin.y - globalCoords.y

        // Set squareCoords with four corners of the bounding box
        self.squareCoords = [
            CGPoint(x: minX, y: minY),
            CGPoint(x: maxX, y: minY),
            CGPoint(x: maxX, y: maxY),
            CGPoint(x: minX, y: maxY)
        ]

        // Calculate the center point of the bounding rect
        let centerX = boundingRect.midX
        let centerY = boundingRect.maxY
        let wordCenter = CGPoint(x: centerX + globalOrigin.x, y: centerY + globalOrigin.y - globalCoords.y)

        return wordCenter
    }
}

@available(iOS 15, *)
struct AttributedText: View {
    let text: String
    let startIndex: Int
    let endIndex: Int
    let fontSize: CGFloat
    let isZacherkn: Bool

    var body: some View {
        Text(makeAttributedString())
            .font(.system(size: fontSize))
    }

    private func makeAttributedString() -> AttributedString {
        var attributedString = AttributedString(text)
        let nsRange = NSRange(location: startIndex, length: endIndex - startIndex)
        if let range = Range(nsRange, in: attributedString) {
            attributedString[range].backgroundColor = .green.opacity(1)
            attributedString[range].strikethroughStyle = isZacherkn ? .single : .none
        }
        return attributedString
    }
}

struct RectanglePathView: View {
    @Binding var squareCoords: [CGPoint]

    var body: some View {
        Path { path in
            // Draw the rectangle around the specified text
            path.move(to: squareCoords[0])
            path.addLine(to: squareCoords[1])
            path.addLine(to: squareCoords[2])
            path.addLine(to: squareCoords[3])
            path.closeSubpath()
        }
        .stroke(Color.purple, lineWidth: 2)
        //        .edgesIgnoringSafeArea(.all)
    }
}

struct ArrowPathView: View {
    @Binding var startCoordinates: CGPoint
    @Binding var endCoordinates: CGPoint

    var body: some View {
        Path { path in
            // Starting point (point A)
            let startPoint = startCoordinates
            path.move(to: startPoint)

            // Ending point (point B)
            let endPoint = endCoordinates
            path.addLine(to: endPoint)

            // Add arrowhead at the start point
            let arrowLength: CGFloat = 15
            let angle = CGFloat.pi / 5
            let dx1 = startPoint.x - endPoint.x
            let dy1 = startPoint.y - endPoint.y

            let angle1a = atan2(dy1, dx1) + angle
            let angle2a = atan2(dy1, dx1) - angle

            let arrowPoint1a = CGPoint(x: startPoint.x - arrowLength * cos(angle1a), y: startPoint.y - arrowLength * sin(angle1a))
            let arrowPoint2a = CGPoint(x: startPoint.x - arrowLength * cos(angle2a), y: startPoint.y - arrowLength * sin(angle2a))

            path.move(to: startPoint)
            path.addLine(to: arrowPoint1a)
            path.move(to: startPoint)
            path.addLine(to: arrowPoint2a)

            // Add arrowhead at the end point
            let dx2 = endPoint.x - startPoint.x
            let dy2 = endPoint.y - startPoint.y

            let angle1b = atan2(dy2, dx2) + angle
            let angle2b = atan2(dy2, dx2) - angle

            let arrowPoint1b = CGPoint(x: endPoint.x - arrowLength * cos(angle1b), y: endPoint.y - arrowLength * sin(angle1b))
            let arrowPoint2b = CGPoint(x: endPoint.x - arrowLength * cos(angle2b), y: endPoint.y - arrowLength * sin(angle2b))

            path.move(to: endPoint)
            path.addLine(to: arrowPoint1b)
            path.move(to: endPoint)
            path.addLine(to: arrowPoint2b)
        }
        .stroke(Color.red, lineWidth: 3)
        //        .edgesIgnoringSafeArea(.all)
    }
}

struct TeacherCommentPopUpView: View {

    @State var numOfComment: String
    @State var textOfComment: String

    var body: some View {
            VStack() {
                VStack(alignment: .leading) {
                    Text("Ком \(numOfComment):")
                        .bold()
                        .font(.system(size: 15))
                    Text("\(textOfComment)")
                        .font(.system(size: 15))
                }
                .padding(10)
                .background(Color.white)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.purple, lineWidth: 3)
            )
            //        .fixedSize(horizontal: false, vertical: false)
            //        .frame(maxWidth: UIScreen.main.bounds.width * 0.6)
            .fixedSize(horizontal: false, vertical: true) // Allow vertical expansion
            .frame(maxWidth: UIScreen.main.bounds.width * 0.7)
    }
}

#Preview {
    KnowledgeCheckView()
}
