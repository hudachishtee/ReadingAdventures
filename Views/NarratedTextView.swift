//
//  NarratedTextView.swift
//  ReadingAdventures
//
//  Created by Huda Chishtee on 13/05/2026.
//

import SwiftUI

struct NarratedTextView: View {
    
    let text: String
    let currentWordIndex: Int
    let themeColor: Color
    let isIPad: Bool
    
    private var lines: [[String]] {
        
        text
            .components(separatedBy: "\n")
            .filter {
                !$0.trimmingCharacters(in: .whitespaces).isEmpty
            }
            .map {
                $0.components(separatedBy: .whitespaces)
                    .filter { !$0.isEmpty }
            }
    }
    
    var body: some View {
        
        VStack(
            alignment: .leading,
            spacing: isIPad ? 28 : 20
        ) {
            
            ForEach(lines.indices, id: \.self) { lineIndex in
                
                let words = lines[lineIndex]
                
                FlowLayout(
                    spacing: 6
                ) {
                    
                    ForEach(words.indices, id: \.self) { wordIndex in
                        
                        let word = words[wordIndex]
                        
                        let currentIndex = globalWordIndex(
                            lineIndex: lineIndex,
                            wordIndex: wordIndex
                        )
                        
                        Text(word)
                            .font(
                                .custom(
                                    "OpenDyslexic-Regular",
                                    size: isIPad ? 26 : 18
                                )
                            )
                            .tracking(-0.4)
                            
                            .foregroundStyle(
                                currentWordIndex == currentIndex
                                ? Color.white
                                : Color.appPrimaryText
                            )
                            
                            .padding(.horizontal, 8)
                            .padding(.vertical, 5)
                            
                            .background {
                                
                                Capsule()
                                    .fill(
                                        currentWordIndex == currentIndex
                                        ? Color.white.opacity(0.28)
                                        : Color.clear
                                    )
                                    .scaleEffect(
                                        currentWordIndex == currentIndex
                                        ? 1.04
                                        : 0.96
                                    )
                                    .animation(
                                        .spring(
                                            response: 0.28,
                                            dampingFraction: 0.82
                                        ),
                                        value: currentWordIndex
                                    )
                            }
                            
                            .scaleEffect(
                                currentWordIndex == currentIndex
                                ? 1.03
                                : 1.0
                            )
                            
                            .animation(
                                .easeInOut(duration: 0.18),
                                value: currentWordIndex
                            )
                            
                            .id(currentIndex)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .fixedSize(horizontal: false, vertical: true)
        .padding(.vertical, 5)
    }
    
    // MARK: - Global Word Index
    
    private func globalWordIndex(
        lineIndex: Int,
        wordIndex: Int
    ) -> Int {
        
        let previousWords =
        lines
            .prefix(lineIndex)
            .flatMap { $0 }
            .count
        
        return previousWords + wordIndex
    }
}

// MARK: - Flow Layout

struct FlowLayout: Layout {
    
    var spacing: CGFloat = 6
    
    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        
        let width = proposal.width ?? 0
        
        var currentX: CGFloat = 0
        var currentY: CGFloat = 0
        var rowHeight: CGFloat = 0
        
        for subview in subviews {
            
            let size = subview.sizeThatFits(.unspecified)
            
            if currentX + size.width > width {
                
                currentX = 0
                currentY += rowHeight + spacing
                rowHeight = 0
            }
            
            rowHeight = max(rowHeight, size.height)
            
            currentX += size.width + spacing
        }
        
        return CGSize(
            width: width,
            height: currentY + rowHeight
        )
    }
    
    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        
        var currentX = bounds.minX
        var currentY = bounds.minY
        var rowHeight: CGFloat = 0
        
        for subview in subviews {
            
            let size = subview.sizeThatFits(.unspecified)
            
            if currentX + size.width > bounds.maxX {
                
                currentX = bounds.minX
                currentY += rowHeight + spacing
                rowHeight = 0
            }
            
            subview.place(
                at: CGPoint(x: currentX, y: currentY),
                proposal: ProposedViewSize(size)
            )
            
            currentX += size.width + spacing
            
            rowHeight = max(rowHeight, size.height)
        }
    }
}

#Preview {
    
    ZStack {
        
        LinearGradient(
            colors: [
                .orange,
                .yellow
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
        
        NarratedTextView(
            text:
"""
Nora packed two sandwiches today.
She did not know why.
It just felt right.
""",
            currentWordIndex: 4,
            themeColor: .orange,
            isIPad: false
        )
        .padding(24)
    }
}
