//
//  ModelPricingView.swift
//
//
//  Created by Kevin Hermawan on 28/12/23.
//

import CoreModels
import CoreViewModels
import SwiftUI
import ViewCondition

public struct ModelPricingView: View {
    @Environment(\.openURL) private var openURL
    @Environment(DalleModelInfoViewModel.self) private var dalleModelInfoViewModel
    
    public init() {}
    
    @MainActor
    private var navigationSubtitle: String {
        switch dalleModelInfoViewModel.viewState {
        case .loading:
            return "Fetching..."
        case .error(let message):
            return message
        default:
            guard let updatedAt = dalleModelInfoViewModel.pricingUpdatedAt else { return "" }
            let updatedAtFormatted = updatedAt.formatted(date: .numeric, time: .omitted)
            
            return "Last updated on \(updatedAtFormatted)"
        }
    }
    
    public var body: some View {
        NavigationStack {
            Table(dalleModelInfoViewModel.pricing ) {
                TableColumn("Model") {
                    Text($0.model.title)
                        .fontWeight(.semibold)
                }
                
                TableColumn("Quality", value: \.qualityTitle)
                TableColumn("Resolution", value: \.resolution)
                
                TableColumn("Price") {
                    Text($0.attributedPrice)
                }
                .alignment(.trailing)
            }
            .navigationTitle("Model Pricing")
            .navigationSubtitle(navigationSubtitle)
            .task {
                await dalleModelInfoViewModel.fetch()
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Pricing Info", systemImage: "info.circle") {
                        pricingInfoAction()
                    }
                    .labelStyle(.titleAndIcon)
                }
            }
        }
    }
    
    @MainActor
    func pricingInfoAction() {
        guard let infoUrl = dalleModelInfoViewModel.pricingInfoUrl else { return }
        guard let url = URL(string: infoUrl) else { return }
        
        openURL(url)
    }
}
