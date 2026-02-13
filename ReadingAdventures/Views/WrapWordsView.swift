////
////  WrapWordsView.swift
////  ReadingAdventures
////
////  Created by Huda Chishtee on 13/02/2026.
////
//
//import SwiftUI
//
//struct WrapWordsView: View {
//
//    let words: [String]
//    let highlightedIndex: Int
//
//    var body: some View {
//        FlexibleView(
//            data: words.indices,
//            spacing: 6,
//            alignment: .leading
//        ) { index in
//            Text(words[index])
//                .font(OpenDyslexicFont.regular(size: 26))
//                .padding(.vertical, 6)
//                .padding(.horizontal, 8)
//                .background(
//                    highlightedIndex == index
//                    ? Color.yellow.opacity(0.6)
//                    : Color.clear
//                )
//                .cornerRadius(6)
//        }
//    }
//}
