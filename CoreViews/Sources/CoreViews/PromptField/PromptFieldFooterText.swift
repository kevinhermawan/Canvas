//
//  PromptFieldFooterText.swift
//
//
//  Created by Kevin Hermawan on 26/12/23.
//

import SettingsModule
import SwiftUI
import ViewState

struct PromptFieldFooterText: View {
    @Environment(SettingsManager.self) private var settingsManager
    
    private var viewState: ViewState?
    
    init(viewState: ViewState? = nil) {
        self.viewState = viewState
    }
    
    private var message: String {
        if settingsManager.autosaveEnabled {
            return "A good prompt is essential for the best possible image generation results."
        }
        
        return "Auto-save is not enabled; remember to manually save the results."
    }
    
    var body: some View {
        Text(message)
            .when(viewState, is: .loading) {
                Text("Generating image...")
            }
            .foregroundStyle(.secondary)
            .whenError(viewState) { message in
                Text(LocalizedStringKey(message))
                    .foregroundStyle(.red)
            }
            .font(.callout)
    }
}
