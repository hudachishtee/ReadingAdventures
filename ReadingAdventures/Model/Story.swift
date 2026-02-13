//
//  Story.swift
//  ReadingAdventures
//
//  Created by Huda Chishtee on 13/02/2026.
//

import Foundation

struct Story: Identifiable, Equatable, Hashable {
    let id = UUID()
    let title: String
    let description: String
    let coverImage: String
}
