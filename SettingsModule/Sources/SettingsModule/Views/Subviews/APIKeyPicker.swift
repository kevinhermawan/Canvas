//
//  APIKeyPicker.swift
//
//
//  Created by Kevin Hermawan on 11/01/24.
//

import CoreExtensions
import SwiftUI

struct APIKeyPicker: View {
    private var apiKeyMasked: String?
    private var onSetup: (_: String) -> Void
    private var onRemove: () -> Void
    
    @FocusState private var apiKeyFocused: Bool
    @State private var apiKey: String = ""
    
    @State private var isEditing: Bool = false
    
    public init(apiKeyMasked: String?, onSetup: @escaping (_: String) -> Void, onRemove: @escaping () -> Void) {
        self.apiKeyMasked = apiKeyMasked
        self.onSetup = onSetup
        self.onRemove = onRemove
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("API Key")
                    .font(.headline.weight(.semibold))
                
                Spacer()
                
                if isEditing {
                    Button("Cancel") { isEditing = false }
                        .buttonStyle(.link)
                } else {
                    if apiKeyMasked.isNotNil {
                        Button("Remove", action: onRemove)
                            .buttonStyle(.link)
                    }
                }
            }
            
            HStack {
                if isEditing {
                    TextField("", text: $apiKey)
                        .focused($apiKeyFocused)
                        .onAppear { apiKeyFocused = true }
                        .onSubmit { doneAction() }
                } else {
                    if let apiKeyMasked {
                        Text(apiKeyMasked)
                            .foregroundStyle(.secondary)
                    } else {
                        Text("Please set the API key")
                            .foregroundStyle(.red)
                    }
                }
                
                Spacer()
                
                if isEditing {
                    Button("Done", action: doneAction)
                } else {
                    Button("Change") { isEditing = true }
                }
            }
        }
        .padding(4)
    }
    
    private func doneAction() {
        onSetup(apiKey)
        
        apiKey = ""
        isEditing = false
    }
}
