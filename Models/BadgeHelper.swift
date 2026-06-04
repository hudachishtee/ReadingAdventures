//
//  BadgeHelper.swift
//  ReadingAdventures
//

import Foundation

enum BadgeHelper {
    
    static func badgeImage(for story: Story) -> String {
        
        switch story.title {
            
        case "The Extra Sandwich":
            return "story1_badge"
            
        case "The Brave Little Wave":
            return "story2_badge"
            
        case "The Sunset Promise":
            return "story3_badge"
            
        case "The Lost Crayon":
            return "story4_badge"
            
        case "Milo the Cat":
            return "story5_badge"
            
        case "The Quiet Moon":
            return "story6_badge"
            
        case "The Lost Little Bird":
            return "story7_badge"
            
        case "The Rainy Day Surprise":
            return "story8_badge"
            
        case "The Floating Balloon":
            return "story9_badge"
            
        case "The Slow and Steady Turtle":
            return "story10_badge"
            
        case "The Light in the Dark":
            return "story11_badge"
            
        case "The Missing Piece":
            return "story12_badge"
            
        case "The Brave Lantern":
            return "story13_badge"
            
        case "The Sky Painter":
            return "story14_badge"
            
        default:
            return "story1_badge"
        }
    }
}
