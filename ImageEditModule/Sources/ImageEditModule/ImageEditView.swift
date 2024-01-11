//
//  ImageEditView.swift
//
//
//  Created by Kevin Hermawan on 25/12/23.
//

import CoreExtensions
import CoreViewModels
import CoreViews
import Defaults
import OpenAI
import SwiftUI

public struct ImageEditView: View {
    @Environment(APIKeyViewModel.self) private var apiKeyViewModel
    @Environment(DalleViewModel.self) private var dalleViewModel
    
    @State private var prompt: String = ""
    
    private var number: Int
    private var size: String
    private var imageData: Data?
    private var maskData: Data?
    
    public init(
        number: Int,
        size: String,
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
        let fileName = UUID().uuidString
        
        let mask = maskData
        let maskFileName: String? = mask.isNotNil ? UUID().uuidString : nil
        
        let query = ImageEditsQuery(image: image, fileName: fileName, mask: mask, maskFileName: maskFileName, prompt: prompt, n: number, size: size)
        
        dalleViewModel.setup(apiKey: apiKeyViewModel.apiKey)
        dalleViewModel.imageEdit(query: query)
    }
}
