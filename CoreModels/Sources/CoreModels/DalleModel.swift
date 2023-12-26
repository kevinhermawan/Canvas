//
//  DalleModel.swift
//
//
//  Created by Kevin Hermawan on 25/12/23.
//

import Defaults
import Foundation

public enum DalleModel: String, CaseIterable {
    case dalle2 = "dall-e-2"
    case dalle3 = "dall-e-3"
    
    public var title: String {
        switch self {
        case .dalle2:
            return "DALL·E 2"
        case .dalle3:
            return "DALL·E 3"
        }
    }
    
    public var numbers: [Int] {
        switch self {
        case .dalle2:
            return Array(1...10)
        case .dalle3:
            return Array(arrayLiteral: 1)
        }
    }
    
    public var sizes: [String] {
        switch self {
        case .dalle2:
            return ["256x256", "512x512", "1024x1024"]
        case .dalle3:
            return ["1024x1024", "1024x1792", "1792x1024"]
        }
    }
}

extension DalleModel: Identifiable {
    public var id: String {
        self.rawValue
    }
}

extension DalleModel: Defaults.Serializable {}

extension DalleModel {
    public enum Quality: String, CaseIterable, Identifiable, Defaults.Serializable {
        case standard
        case hd
        
        public var id: String {
            self.rawValue
        }
        
        public var title: String {
            switch self {
            case .standard:
                return "Standard"
            case .hd:
                return "HD"
            }
        }
    }
    
    public var qualities: [Quality]? {
        switch self {
        case .dalle2:
            return nil
        case .dalle3:
            return [.standard, .hd]
        }
    }
}

extension DalleModel {
    public enum Style: String, CaseIterable, Identifiable, Defaults.Serializable {
        case vivid
        case natural
        
        public var id: String {
            self.rawValue
        }
        
        public var title: String {
            switch self {
            case .vivid:
                return "Vivid"
            case .natural:
                return "Natural"
            }
        }
    }
    
    public var styles: [Style]? {
        switch self {
        case .dalle2:
            return nil
        case .dalle3:
            return [.vivid, .natural]
        }
    }
}
