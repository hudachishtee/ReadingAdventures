//
//  Scale.swift
//  ReadingAdventures
//
//  Created by Huda Chishtee on 06/04/2026.
//

import SwiftUI

struct Scale {

    static let baseWidth: CGFloat = 390   // modern iPhone base

    static var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }

    static var isPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }

    static var factor: CGFloat {
        let raw = screenWidth / baseWidth

        return isPad
            ? min(max(raw, 1.0), 1.25)
            : min(max(raw, 0.90), 1.15)
    }
    
    static func value(_ value: CGFloat) -> CGFloat {
        value * factor
    }

    static func spacing(_ value: CGFloat) -> CGFloat {
        value * factor
    }

    static func radius(_ value: CGFloat) -> CGFloat {
        value * factor
    }

    static func icon(_ value: CGFloat) -> CGFloat {
        value * factor
    }

    static func image(_ value: CGFloat) -> CGFloat {
        value * factor
    }

    static func font(_ value: CGFloat) -> CGFloat {
        value * factor
    }
}
