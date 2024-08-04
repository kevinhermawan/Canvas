//
//  CircleButton.swift
//
//
//  Created by Kevin Hermawan on 25/12/23.
//

import SwiftUI

public struct CircleButton: View {
    private let systemImage: String
    private let action: () -> Void
    
    public init(systemImage: String, action: @escaping () -> Void) {
        self.systemImage = systemImage
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .foregroundStyle(.foreground)
                .fontWeight(.bold)
                .padding(8)
        }
        .background(.background)
        .buttonStyle(.borderless)
        .clipShape(.circle)
        .colorInvert()
    }
}
