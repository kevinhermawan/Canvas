//
//  DalleModelInfo.swift
//
//
//  Created by Kevin Hermawan on 28/12/23.
//

import Foundation

public struct DalleModelInfo: Codable {
    public let pricing: [Pricing]
    public let pricingInfoUrl: String
    public let pricingUpdatedAt: Date
}

extension DalleModelInfo {
    public struct Pricing: Identifiable, Codable {
        public let model: DalleModel
        public let quality: DalleModel.Quality?
        public let resolution: String
        public let price: Double
        
        public var id: String {
            if let quality {
                return "\(model)-\(quality)-\(resolution)"
            }
            
            return "\(model)-\(resolution)"
        }
        
        public var qualityTitle: String {
            quality?.title ?? "-"
        }
        
        public var formattedPrice: String {
            String(format: "$%.3f", price)
        }
        
        public var attributedPrice: AttributedString {
            var attributedString = AttributedString(formattedPrice)
            var unitString = AttributedString(" / image")
            unitString.foregroundColor = .secondary
            
            attributedString.append(unitString)
            
            return attributedString
        }
    }
}
