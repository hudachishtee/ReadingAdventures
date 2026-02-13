//
//  ContentView.swift
//  ReadingAdventures
//
//  Created by Huda Chishtee on 13/02/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("HELLO WORLD")
                .font(.custom("OpenDyslexic-Bold", size: 40))

            Text("This should be OpenDyslexic Regular")
                .font(.custom("OpenDyslexic-Regular", size: 22))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
