//
//  SizePicker.swift
//
//
//  Created by Kevin Hermawan on 26/12/23.
//

import CoreViews
import SwiftUI

struct SizePicker: View {
    private let sizes: [String]
    @Binding private var selection: String
    
    init(_ sizes: [String], selection: Binding<String>) {
        self.sizes = sizes
        self._selection = selection
    }
    
    var body: some View {
        Section {
            Picker("Select size", selection: $selection) {
                ForEach(sizes, id: \.self) { size in
                    Text(size).tag(size)
                }
            }
        } header: {
            Text("Size")
        } footer: {
            FootnoteText("FOOTNOTE_SIZE")
        }
    }
}
