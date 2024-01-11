//
//  PromptFieldFooterText.swift
//
//
//  Created by Kevin Hermawan on 26/12/23.
//

import CoreExtensions
import SettingsModule
import SwiftUI
import ViewState

struct PromptFieldFooterText: View {
    @Environment(SettingsManager.self) private var settingsManager
    
    private var viewState: ViewState?
    
    init(viewState: ViewState? = nil) {
        self.viewState = viewState
    }
    
    private var message: AttributedString {
        guard settingsManager.autosaveEnabled else {
            var string = AttributedString("Auto-save is disabled. Remember to manually save your results.")
            string.foregroundColor = .orange
            
            return string
        }
        
        guard settingsManager.apiKey.isNotNil else {
            var string = AttributedString("Please set your API key in the settings to perform the action.")
            string.foregroundColor = .red
            
            return string
        }
        
        var string = AttributedString("A good prompt is essential for the best possible image generation results.")
        string.foregroundColor = .secondary
        
        return string
    }
    
    var body: some View {
        Text(message)
            .when(viewState, is: .loading) {
                Text("Generating image...")
                    .foregroundStyle(.secondary)
            }
            .whenError(viewState) { message in
                Text(LocalizedStringKey(message))
                    .foregroundStyle(.red)
            }
            .font(.callout)
    }
}
