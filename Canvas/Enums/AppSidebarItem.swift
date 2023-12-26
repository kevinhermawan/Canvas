//
//  AppSidebarItem.swift
//  Canvas
//
//  Created by Kevin Hermawan on 25/12/23.
//

import Foundation

enum AppSidebarItem: String, CaseIterable {
    case imageGeneration
    case imageEdit
    case imageVariation
    
    var title: String {
        switch self {
        case .imageGeneration:
            return "Image Generation"
        case .imageEdit:
            return "Image Edit"
        case .imageVariation:
            return "Image Variation"
        }
    }
    
    var systemImage: String {
        switch self {
        case .imageGeneration:
            return "paintbrush"
        case .imageEdit:
            return "theatermask.and.paintbrush"
        case .imageVariation:
            return "paintpalette"
        }
    }
}

extension AppSidebarItem: Identifiable {
    var id: String {
        self.rawValue
    }
}
