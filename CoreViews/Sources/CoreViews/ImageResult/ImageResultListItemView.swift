//
//  ImageResultListItemView.swift
//
//
//  Created by Kevin Hermawan on 25/12/23.
//

import CoreExtensions
import SettingsModule
import NukeUI
import SwiftUI

public struct ImageResultListItemView: View {
    @Environment(SettingsManager.self) private var settingsManager
    
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
                    .onAppear {
                        autosaveAction(for: imageContainer.image)
                    }
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
    
    private func autosaveAction(for image: NSImage) {
        let fileManager = FileManager.default
        
        if settingsManager.autosaveEnabled {
            var isDir: ObjCBool = false
            var location = settingsManager.autosaveLocation
            
            if fileManager.fileExists(atPath: location.path, isDirectory: &isDir) {
                location.append(path: url.lastPathComponent)
                
                try? image.write(to: location)
            } else {
                try? fileManager.createDirectory(atPath: location.path, withIntermediateDirectories: true, attributes: nil)
                location.append(path: url.lastPathComponent)
                
                try? image.write(to: location)
            }
        }
    }
}
