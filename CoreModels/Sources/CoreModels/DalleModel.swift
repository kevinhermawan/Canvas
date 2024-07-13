//
//  DalleModel.swift
//
//
//  Created by Kevin Hermawan on 25/12/23.
//

import Defaults
import Foundation
import OpenAI

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
}

extension DalleModel: Identifiable {
    public var id: String {
        self.rawValue
    }
}

extension DalleModel: Codable, Defaults.Serializable {}

extension DalleModel {
    public enum Size: String, CaseIterable, Identifiable, Codable, Defaults.Serializable {
        case _256, _512, _1024, _1024_1792, _1792_1024
        
        public var id: String {
            self.rawValue
        }
        
        public var title: String {
            switch self {
            case ._256:
                return "256x256 (Square)"
            case ._512:
                return "512x512 (Square)"
            case ._1024:
                return "1024x1024 (Square)"
            case ._1024_1792:
                return "1024x1792 (Landscape)"
            case ._1792_1024:
                return "1792x1024 (Portrait)"
            }
        }
        
        public var imagesQuery: ImagesQuery.Size {
            switch self {
            case ._256:
                return ._256
            case ._512:
                return ._512
            case ._1024:
                return ._1024
            case ._1024_1792:
                return ._1024_1792
            case ._1792_1024:
                return ._1792_1024
            }
        }
    }
    
    public var sizes: [Size] {
        switch self {
        case .dalle2:
            return [._256, ._512, ._1024]
        case .dalle3:
            return [._1024, ._1024_1792, ._1792_1024]
        }
    }
}

extension DalleModel {
    public enum Quality: String, CaseIterable, Identifiable, Codable, Defaults.Serializable {
        case standard, hd
        
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
        
        public var imagesQuery: ImagesQuery.Quality {
            switch self {
            case .standard:
                return .standard
            case .hd:
                return .hd
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
        case vivid, natural
        
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
        
        public var imagesQuery: ImagesQuery.Style {
            switch self {
            case .vivid:
                return .vivid
            case .natural:
                return .natural
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
