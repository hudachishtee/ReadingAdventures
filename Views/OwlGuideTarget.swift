//
//  OwlGuideTarget.swift
//  ReadingAdventures
//
//  Created by Huda Chishtee on 26/08/2026.
//

import SwiftUI

// ================================================================
// OWL GUIDE TARGET PREFERENCE
// ================================================================

struct OwlGuideTargetPreferenceKey: PreferenceKey {

    static var defaultValue: [String: Anchor<CGRect>] = [:]

    static func reduce(
        value: inout [String: Anchor<CGRect>],
        nextValue: () -> [String: Anchor<CGRect>]
    ) {
        value.merge(
            nextValue(),
            uniquingKeysWith: { _, new in new }
        )
    }
}

// ================================================================
// OWL GUIDE TARGET MODIFIER
// ================================================================

struct OwlGuideTargetModifier: ViewModifier {

    let id: String

    func body(content: Content) -> some View {

        content
            .anchorPreference(
                key: OwlGuideTargetPreferenceKey.self,
                value: .bounds
            ) { anchor in

                [
                    id: anchor
                ]
            }
    }
}

// ================================================================
// OWL GUIDE TARGET EXTENSION
// ================================================================

extension View {

    func owlGuideTarget(_ id: String) -> some View {

        modifier(
            OwlGuideTargetModifier(id: id)
        )
    }
}
