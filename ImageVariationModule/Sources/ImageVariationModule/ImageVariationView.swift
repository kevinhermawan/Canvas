//
//  ImageVariationView.swift
//
//
//  Created by Kevin Hermawan on 25/12/23.
//

import CoreModels
import CoreViewModels
import CoreViews
import OpenAI
import SwiftUI
import ViewCondition
import ViewState

public struct ImageVariationView: View {
    @Environment(APIKeyViewModel.self) private var apiKeyViewModel
    @Environment(DalleViewModel.self) private var dalleViewModel
    
    private var number: Int
    private var size: String
    private var imageData: Data?
    
    public init(
        number: Int,
        size: String,
        imageData: Data? = nil
    ) {
        self.number = number
        self.size = size
        self.imageData = imageData
    }
    
    @MainActor
    private var generating: Bool {
        self.dalleViewModel.viewState == .loading
    }
    
    public var body: some View {
        VStack {
            ImageResultListView(dalleViewModel.results) { url in
                ImageResultListItemView(url: url).tag(url)
            }
            
            HStack {
                if let errorMessage = dalleViewModel.viewState?.errorMessage {
                    Text(LocalizedStringKey(errorMessage))
                        .foregroundStyle(.red)
                        .font(.callout)
                }
                
                Spacer()
                
                Button(action: { generationAction() }) {
                    Label("Generate Variation", systemImage: "arrow.up.circle.fill")
                        .padding(.vertical, 8)
                        .padding(.horizontal)
                }
                .buttonStyle(.borderedProminent)
                .hide(if: generating, removeCompletely: true)
                
                Button(action: { dalleViewModel.cancel() }) {
                    Label("Cancel Generation", systemImage: "stop.fill")
                        .padding(.vertical, 8)
                        .padding(.horizontal)
                }
                .buttonStyle(.bordered)
                .visible(if: generating, removeCompletely: true)
            }
            .padding()
        }
    }
    
    @MainActor
    func generationAction() {
        let fileName = UUID().uuidString
        guard let image = imageData else { return }
        
        let query = ImageVariationsQuery(image: image, fileName: fileName, n: number, size: size)
        
        dalleViewModel.setup(apiKey: apiKeyViewModel.apiKey)
        dalleViewModel.imageVariation(query: query)
    }
}
