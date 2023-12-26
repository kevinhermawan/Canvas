//
//  SetupAPIKeyView.swift
//
//
//  Created by Kevin Hermawan on 25/12/23.
//

import CoreViewModels
import CoreViews
import SwiftUI

struct SetupAPIKeyView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(APIKeyViewModel.self) private var apiKeyViewModel
    
    @State private var apiKey: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Section {
                    TextField("", text: $apiKey)
                } header: {
                    Text("API Key")
                } footer: {
                    FootnoteText("The API key is only used for image generation and securely stored in the keychain.")
                        .foregroundStyle(.secondary)
                        .padding(.top, 4)
                }
            }
            .padding()
            .frame(width: 384, height: 128)
            .navigationTitle("Setup API Key")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", action: { dismiss() })
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done", action: { doneAction() })
                }
            }
        }
    }
    
    @MainActor
    private func doneAction() {
        apiKeyViewModel.setup(apiKey: apiKey)

        dismiss()
    }
}

#Preview {
    SetupAPIKeyView()
        .environment(APIKeyViewModel())
}
