//
//  Responsive.swift
//  ReadingAdventures
//
//  Created by Huda Chishtee on 02/07/2026.
//

import SwiftUI

struct Responsive {

    let width: CGFloat
    let height: CGFloat
    let safeTop: CGFloat
    let safeBottom: CGFloat

    // MARK: - Device

    var isPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }

    var isPhone: Bool {
        !isPad
    }

    var isCompact: Bool {
        width < 390
    }

    var isLandscape: Bool {
        width > height
    }

    var isPortrait: Bool {
        !isLandscape
    }

    // MARK: - Content Width

    /// Prevents content from stretching across the entire iPad screen.
    var contentWidth: CGFloat {
        if isPad {
            return min(width * 0.82, 720)
        } else {
            return width
        }
    }

    // MARK: - Layout Helpers

    func width(_ percent: CGFloat, max: CGFloat? = nil) -> CGFloat {

        let value = width * percent

        if let max {
            return min(value, max)
        }

        return value
    }

    func height(_ percent: CGFloat, max: CGFloat? = nil) -> CGFloat {

        let value = height * percent

        if let max {
            return min(value, max)
        }

        return value
    }

    var horizontalPadding: CGFloat {
        if isPad {
            return 32
        } else {
            return min(max(width * 0.045, 16), 22)
        }
    }
    var heroCornerRadius: CGFloat {
        isPad ? 40 : 28
    }
    // MARK: - Typography

    func font(_ base: CGFloat) -> CGFloat {

        if isPad {
            return base * 1.12
        }

        if isCompact {
            return base * 0.94
        }

        return base
    }

    // MARK: - Spacing

    func spacing(_ value: CGFloat) -> CGFloat {

        if isPad {
            return value * 1.15
        }

        if isCompact {
            return value * 0.92
        }

        return value
    }

    // MARK: - Radius

    /// Corner radii usually shouldn't scale much.
    func radius(_ value: CGFloat) -> CGFloat {
        value
    }

    // MARK: - Images

    func image(_ percent: CGFloat, max: CGFloat) -> CGFloat {
        min(width * percent, max)
    }

    // MARK: - Semantic Sizes
    
    var heroWidth: CGFloat {
        width - (horizontalPadding * 2)
    }
    var heroHeight: CGFloat {
        if isPad {
            return min(width * 0.36, 360)
        } else {
            return max(170, min(width * 0.42, 240))
        }
    }
    var storyCardWidth: CGFloat {
        if isPad {
            return min(contentWidth * 0.8, 500)
        } else {
            return min(width * 0.82, 330)
        }
    }

    var storyImageHeight: CGFloat {
        if isPad {
            return 280
        } else {
            return 190
        }
    }

    var buttonHeight: CGFloat {
        isPad ? 60 : 54
    }

    var iconSize: CGFloat {
        isPad ? 28 : 24
    }
    var heroTitleSize: CGFloat {
        if isPad {
            return min(heroWidth * 0.065, 48)
        } else {
            return max(24, min(heroWidth * 0.085, 34))
        }
    }

    var heroSubtitleSize: CGFloat {
        if isPad {
            return min(heroWidth * 0.036, 28)
        } else {
            return max(15, min(heroWidth * 0.048, 18))
        }
    }

    var heroOwlWidth: CGFloat {
        if isPad {
            return min(heroWidth * 0.32, 320)
        } else {
            return min(heroWidth * 0.24, 120)
        }
    }
}
