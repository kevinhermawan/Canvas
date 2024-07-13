//
//  SizePicker.swift
//
//
//  Created by Kevin Hermawan on 26/12/23.
//

import CoreModels
import CoreViews
import SwiftUI

struct SizePicker: View {
    private let sizes: [DalleModel.Size]
    @Binding private var selection: DalleModel.Size
    
    init(_ sizes: [DalleModel.Size], selection: Binding<DalleModel.Size>) {
        self.sizes = sizes
        self._selection = selection
    }
    
    var body: some View {
        Section {
            Picker("Select size", selection: $selection) {
                ForEach(sizes, id: \.self) { size in
                    Text(size.title).tag(size)
                }
            }
        } header: {
            Text("Size")
        } footer: {
            FootnoteText("FOOTNOTE_SIZE")
        }
    }
}
