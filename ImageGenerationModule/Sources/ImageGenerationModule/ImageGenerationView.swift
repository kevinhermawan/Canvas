//
//  ImageGenerationView.swift
//
//
//  Created by Kevin Hermawan on 25/12/23.
//

import CoreModels
import CoreViewModels
import CoreViews
import OpenAI
import SettingsModule
import SwiftUI

public struct ImageGenerationView: View {
    @Environment(SettingsManager.self) private var settingsManager
    @Environment(DalleViewModel.self) private var dalleViewModel
    
    @FocusState private var promptFocused: Bool
    @State private var prompt: String = ""
    
    private var model: DalleModel
    private var number: Int
    private var size: DalleModel.Size
    private var quality: DalleModel.Quality?
    private var style: DalleModel.Style?
    
    public init(
        model: DalleModel,
        number: Int,
        size: DalleModel.Size,
        quality: DalleModel.Quality? = nil,
        style: DalleModel.Style? = nil
    ) {
        self.model = model
        self.number = number
        self.size = size
        self.quality = quality
        self.style = style
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
                
                PromptField(prompt: $prompt, viewState: dalleViewModel.viewState) {
                    generationAction()
                } cancellationAction: {
                    dalleViewModel.cancel()
                }
                .padding(.bottom, 8)
                .padding(.horizontal)
            }
            .navigationTitle("Image Generation")
            .onDisappear {
                dalleViewModel.cancel()
            }
        }
    }
    
    @MainActor
    func generationAction() {
        let model = model.rawValue
        let size = size.imagesQuery
        let quality = quality?.imagesQuery
        let style = style?.imagesQuery
        let query = ImagesQuery(prompt: prompt, model: model, n: number, quality: quality, size: size, style: style)
        
        dalleViewModel.setup(apiKey: settingsManager.apiKey)
        dalleViewModel.imageGeneration(query: query)
    }
}
