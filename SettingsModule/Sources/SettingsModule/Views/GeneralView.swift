//
//  GeneralView.swift
//
//
//  Created by Kevin Hermawan on 09/01/24.
//

import SwiftUI
import ViewCondition

struct GeneralView: View {
    @Environment(SettingsManager.self) private var manager
    
    var body: some View {
        @Bindable var manager = manager
        
        VStack(alignment: .leading, spacing: 16) {
            GroupBox {
                APIKeyPicker(
                    apiKeyMasked: manager.apiKeyMasked,
                    onSetup: { manager.setupAPIKey(apiKey: $0) },
                    onRemove: { manager.removeAPIKey() }
                )
            }
            
            GroupBox {
                AutosavePicker(
                    enabled: $manager.autosaveEnabled,
                    location: $manager.autosaveLocation,
                    action: chooseAutosaveDirectoryAction
                )
            }
        }
    }
    
    private func chooseAutosaveDirectoryAction() {
        let openPanel = NSOpenPanel()
        openPanel.canChooseFiles = false
        openPanel.canChooseDirectories = true
        openPanel.canCreateDirectories = true
        openPanel.allowsMultipleSelection = false
        openPanel.prompt = "Choose"
        
        openPanel.begin { response in
            if response == .OK, let url = openPanel.urls.first {
                manager.autosaveLocation = url
            }
        }
    }
}
