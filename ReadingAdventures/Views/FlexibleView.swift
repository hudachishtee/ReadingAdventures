//import SwiftUI
//
//struct FlexibleView<Data: Collection, Content: View>: View where Data.Element: Hashable {
//
//    let data: Data
//    let spacing: CGFloat
//    let alignment: HorizontalAlignment
//    let content: (Data.Element) -> Content
//
//    init(
//        data: Data,
//        spacing: CGFloat = 8,
//        alignment: HorizontalAlignment = .leading,
//        @ViewBuilder content: @escaping (Data.Element) -> Content
//    ) {
//        self.data = data
//        self.spacing = spacing
//        self.alignment = alignment
//        self.content = content
//    }
//
//    var body: some View {
//        GeometryReader { geometry in
//            generateContent(in: geometry)
//        }
//        .frame(maxWidth: .infinity, minHeight: 1, alignment: .leading)
//    }
//
//    private func generateContent(in geometry: GeometryProxy) -> some View {
//        var x: CGFloat = 0
//        var y: CGFloat = 0
//
//        return ZStack(alignment: Alignment(horizontal: alignment, vertical: .top)) {
//            ForEach(Array(data), id: \.self) { element in
//                content(element)
//                    .fixedSize() // 🔑 CRITICAL FIX
//                    .alignmentGuide(.leading) { d in
//                        if x + d.width > geometry.size.width {
//                            x = 0
//                            y += d.height + spacing
//                        }
//                        let result = x
//                        x += d.width + spacing
//                        return result
//                    }
//                    .alignmentGuide(.top) { _ in
//                        let result = y
//                        return result
//                    }
//            }
//        }
//    }
//}
