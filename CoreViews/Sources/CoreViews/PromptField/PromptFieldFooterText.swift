//
//  PromptFieldFooterText.swift
//
//
//  Created by Kevin Hermawan on 26/12/23.
//

import SwiftUI
import ViewState

struct PromptFieldFooterText: View {
    private var viewState: ViewState?
    
    init(viewState: ViewState? = nil) {
        self.viewState = viewState
    }
    
    var body: some View {
        Text("A good prompt is essential for the best possible image generation results.")
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
