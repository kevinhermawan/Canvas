//
//  ImageResultListItemView.swift
//
//
//  Created by Kevin Hermawan on 25/12/23.
//

import NukeUI
import SwiftUI

public struct ImageResultListItemView: View {
    private let url: URL
    
    public init(url: URL) {
        self.url = url
    }
    
    public var body: some View {
        LazyImage(url: url) { state in
            if state.isLoading {
                VStack {
                    ProgressView()
                        .controlSize(.small)
                }
            } else if let error = state.error {
                VStack {
                    Text(error.localizedDescription)
                }
            } else if let image = state.image, let imageContainer = state.imageContainer {
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .contextMenu {
                        ImageResultContextMenu(
                            name: url.lastPathComponent,
                            image: image,
                            imageContainer: imageContainer
                        )
                    }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 302)
        .background(Color(nsColor: .secondarySystemFill))
        .clipShape(.rect(cornerRadius: 8, style: .continuous))
    }
}
