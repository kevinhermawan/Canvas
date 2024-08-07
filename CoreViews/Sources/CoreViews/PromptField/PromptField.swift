//
//  PromptField.swift
//
//
//  Created by Kevin Hermawan on 26/12/23.
//

import ChatField
import SwiftUI
import ViewState

public struct PromptField: View {
    @Binding private var prompt: String
    private var viewState: ViewState?
    private var generationAction: () -> Void
    private var cancellationAction: () -> Void
    
    public init(
        prompt: Binding<String>,
        viewState: ViewState? = nil,
        generationAction: @escaping () -> Void,
        cancellationAction: @escaping () -> Void
    ) {
        self._prompt = prompt
        self.viewState = viewState
        self.generationAction = generationAction
        self.cancellationAction = cancellationAction
    }
    
    private var generating: Bool {
        viewState == .loading
    }
    
    public var body: some View {
        ChatField("Prompt", text: $prompt) {
            generationAction()
        } trailingAccessory: {
            if generating {
                CircleButton(systemImage: "stop.fill", action: cancellationAction)
                    .keyboardShortcut("c", modifiers: .control)
                    .help("Cancel generation")
            } else {
                CircleButton(systemImage: "arrow.up", action: generationAction)
                    .help("Generate image")
            }
        } footer: {
            PromptFieldFooterText(viewState: viewState)
        }
        .chatFieldDisabled(generating)
        .chatFieldStyle(.capsule)
    }
}
