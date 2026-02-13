//
//  TitleBannerView.swift
//  ReadingAdventures
//
//  Created by Huda Chishtee on 13/02/2026.
//
import SwiftUI

// MARK: - Ticket Cut Mask
struct TicketMask: Shape {
    func path(in rect: CGRect) -> Path {
        let cut: CGFloat = 32
        var path = Path()

        path.addRect(rect)

        path.addEllipse(in: CGRect(x: -cut, y: -cut, width: cut * 2, height: cut * 2))
        path.addEllipse(in: CGRect(x: rect.width - cut, y: -cut, width: cut * 2, height: cut * 2))
        path.addEllipse(in: CGRect(x: rect.width - cut, y: rect.height - cut, width: cut * 2, height: cut * 2))
        path.addEllipse(in: CGRect(x: -cut, y: rect.height - cut, width: cut * 2, height: cut * 2))

        return path
    }
}

// MARK: - Title Banner View
struct TitleBannerView: View {
    var body: some View {
        ZStack {

            Color(red: 0.90, green: 0.96, blue: 0.90)
                .frame(width: 800, height: 197)
                .clipShape(TicketMask(), style: FillStyle(eoFill: true))

            Text("Choose A Story")
                .font(OpenDyslexicFont.bold(size: 60))
                .tracking(0)
                .foregroundColor(Color(red: 47/255, green: 93/255, blue: 98/255))
        }
        .frame(width: 679, height: 190)
    }
}

#Preview {
    TitleBannerView()
}

