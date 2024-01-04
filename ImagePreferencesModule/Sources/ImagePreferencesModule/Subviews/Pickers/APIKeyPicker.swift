//
//  APIKeyPicker.swift
//
//
//  Created by Kevin Hermawan on 26/12/23.
//

import CoreViews
import SwiftUI
import ViewCondition

struct APIKeyPicker: View {
    @Binding private var apiKey: String?
    private var setupAction: () -> Void
    private var removeAction: () -> Void
    
    init(
        apiKey: Binding<String?>,
        setupAction: @escaping () -> Void,
        removeAction: @escaping () -> Void
    ) {
        self._apiKey = apiKey
        self.setupAction = setupAction
        self.removeAction = removeAction
    }
    
    var apiKeyMasked: String {
        let prefixLength = 3
        let suffixLength = 4
        
        guard let apiKey, apiKey.count > prefixLength + suffixLength else { return "No API Key" }
        let prefix = apiKey.prefix(prefixLength)
        let suffix = apiKey.suffix(suffixLength)
        
        return "\(prefix)··········\(suffix)"
    }
    
    var body: some View {
        Section {
            HStack {
                Text(apiKeyMasked)
                
                Spacer()
                
                if apiKey.isNil {
                    Button("Setup", action: setupAction)
                } else {
                    Button("Change", action: setupAction)
                }
            }
        } header: {
            SectionHeader("API Key")
                .if(apiKey.isNotNil) { view in
                    view.action("Remove", action: removeAction)
                }
        } footer: {
            if apiKey.isNil {
                FootnoteText("FOOTNOTE_API_KEY_SETUP")
                    .foregroundStyle(.red)
            } else {
                FootnoteText("FOOTNOTE_API_KEY")
            }
        }
    }
}
