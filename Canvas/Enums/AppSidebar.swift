//
//  AppSidebar.swift
//  Canvas
//
//  Created by Kevin Hermawan on 25/12/23.
//

import Foundation

enum AppSidebar: String, CaseIterable {
    case dalle
    case dalle2
    
    var title: String {
        switch self {
        case .dalle:
            return "DALL·E"
        case .dalle2:
            return "DALL·E 2"
        }
    }
}

extension AppSidebar: Identifiable {
    var id: String {
        self.rawValue
    }
}

extension AppSidebar {
    var items: [AppSidebarItem] {
        switch self {
        case .dalle:
            return [.imageGeneration]
        case .dalle2:
            return [.imageEdit, .imageVariation]
        }
    }
}
