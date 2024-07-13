//
//  ImageVariationView.swift
//
//
//  Created by Kevin Hermawan on 25/12/23.
//

import CoreModels
import CoreModels
import CoreViewModels
import CoreViews
import OpenAI
import SettingsModule
import SwiftUI
import ViewCondition
import ViewState

public struct ImageVariationView: View {
    @Environment(SettingsManager.self) private var settingsManager
    @Environment(DalleViewModel.self) private var dalleViewModel
    
    private var number: Int
    private var size: DalleModel.Size?
    private var imageData: Data?
    
    public init(
        number: Int,
        size: DalleModel.Size? = nil,
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
        NavigationStack {
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
            .navigationTitle("Image Variation")
            .onDisappear {
                dalleViewModel.cancel()
            }
        }
    }
    
    @MainActor
    func generationAction() {
        guard let image = imageData else { return }
        let size = size?.rawValue
        let query = ImageVariationsQuery(image: image, n: number, size: size)
        
        dalleViewModel.setup(apiKey: settingsManager.apiKey)
        dalleViewModel.imageVariation(query: query)
    }
}
