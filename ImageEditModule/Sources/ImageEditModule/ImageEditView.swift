//
//  ImageEditView.swift
//
//
//  Created by Kevin Hermawan on 25/12/23.
//

import CoreExtensions
import CoreModels
import CoreViewModels
import CoreViews
import Defaults
import OpenAI
import SettingsModule
import SwiftUI

public struct ImageEditView: View {
    @Environment(SettingsManager.self) private var settingsManager
    @Environment(DalleViewModel.self) private var dalleViewModel
    
    @State private var prompt: String = ""
    
    private var number: Int
    private var size: DalleModel.Size?
    private var imageData: Data?
    private var maskData: Data?
    
    public init(
        number: Int,
        size: DalleModel.Size? = nil,
        imageData: Data? = nil,
        maskData: Data? = nil
    ) {
        self.number = number
        self.size = size
        self.imageData = imageData
        self.maskData = maskData
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
            .navigationTitle("Image Edit")
            .onDisappear {
                dalleViewModel.cancel()
            }
        }
    }
    
    @MainActor
    func generationAction() {
        guard let image = imageData else { return }
        guard let mask = maskData else { return }
        let size = size?.imagesQuery
        let query = ImageEditsQuery(image: image, prompt: prompt, mask: mask, size: size)
        
        dalleViewModel.setup(apiKey: settingsManager.apiKey)
        dalleViewModel.imageEdit(query: query)
    }
}
