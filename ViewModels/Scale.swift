//
//  Scale.swift
//  ReadingAdventures
//
//  Created by Huda Chishtee on 06/04/2026.
//

import SwiftUI

struct Scale {
    static let baseWidth: CGFloat = 375
    
    static func factor(_ geo: GeometryProxy) -> CGFloat {
        let raw = geo.size.width / baseWidth
        
        // 🔥 Clamp scaling (VERY IMPORTANT)
        return min(max(raw, 0.85), 1.4)
    }
}
