//
//  ImageResultContextMenu.swift
//
//
//  Created by Kevin Hermawan on 26/12/23.
//

import Nuke
import NukeUI
import SwiftUI

struct ImageResultContextMenu: View {
    private let name: String
    private var image: Image
    private var imageContainer: ImageContainer
    
    init(name: String, image: Image, imageContainer: ImageContainer) {
        self.name = name
        self.image = image
        self.imageContainer = imageContainer
    }
    
    var body: some View {
        Button("Copy", action: copy)
        Button("Save", action: save)
        ShareLink("Share", item: image, preview: SharePreview(name, image: image))
    }
    
    private func copy() {
        let nsImage = imageContainer.image
        let pasteboard = NSPasteboard.general
        
        pasteboard.clearContents()
        pasteboard.writeObjects([nsImage])
    }
    
    private func save() {
        let nsImage = imageContainer.image
        
        let savePanel = NSSavePanel()
        savePanel.allowedContentTypes = [.png]
        savePanel.canCreateDirectories = true
        savePanel.nameFieldStringValue = name
        
        savePanel.begin { response in
            guard response == .OK, let url = savePanel.url else { return }
            guard let tiffData = nsImage.tiffRepresentation else { return }
            guard let bitmapImage = NSBitmapImageRep(data: tiffData) else { return }
            guard let pngData = bitmapImage.representation(using: .png, properties: [:]) else { return }
            
            try? pngData.write(to: url)
        }
    }
}
