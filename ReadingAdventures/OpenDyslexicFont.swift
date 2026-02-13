//
//  OpenDyslexicFont.swift
//  ReadingAdventures
//
//  Created by Huda Chishtee on 13/02/2026.
//

import SwiftUI

enum OpenDyslexicFont {
    static func bold(size: CGFloat) -> Font {
        .custom("OpenDyslexic-Bold", size: size)
    }

    static func regular(size: CGFloat) -> Font {
        .custom("OpenDyslexic-Regular", size: size)
    }
}
