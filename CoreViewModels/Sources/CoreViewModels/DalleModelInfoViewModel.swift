//
//  DalleModelInfoViewModel.swift
//
//
//  Created by Kevin Hermawan on 28/12/23.
//

import AppInfo
import CoreModels
import Foundation
import ViewState

@MainActor
@Observable
public final class DalleModelInfoViewModel {
    private var session: URLSession
    
    public var pricing: [DalleModelInfo.Pricing] = []
    public var pricingInfoUrl: String? = nil
    public var pricingUpdatedAt: Date? = nil
    public var viewState: ViewState? = nil
    
    public init() {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        
        self.session = URLSession(configuration: configuration)
        self.session.configuration.urlCache?.removeAllCachedResponses()
    }
    
    private var decoder: JSONDecoder {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        return decoder
    }
    
    public func fetch() async {
        self.viewState = .loading
        
        do {
            guard let urlString = AppInfo.value(for: "MODEL_INFO_URL") else {
                throw URLError(.cannotFindHost)
            }
            
            guard let url = URL(string: urlString) else {
                throw URLError(.badURL)
            }
            
            let (data, response) = try await session.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            
            let result = try decoder.decode(DalleModelInfo.self, from: data)
            self.pricing = result.pricing
            self.pricingInfoUrl = result.pricingInfoUrl
            self.pricingUpdatedAt = result.pricingUpdatedAt
            
            self.viewState = nil
        } catch {
            guard error.localizedDescription != "cancelled" else { return }
            
            self.viewState = .error(message: error.localizedDescription)
        }
    }
}
