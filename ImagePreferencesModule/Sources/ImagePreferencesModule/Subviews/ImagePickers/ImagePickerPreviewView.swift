//
//  ImagePickerPreviewView.swift
//
//
//  Created by Kevin Hermawan on 26/12/23.
//

import SwiftUI

struct ImagePickerPreviewView: View {
    private var data: Data
    
    init(data: Data) {
        self.data = data
    }
    
    var body: some View {
        if let nsImage = NSImage(data: data) {
            Image(nsImage: nsImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}
