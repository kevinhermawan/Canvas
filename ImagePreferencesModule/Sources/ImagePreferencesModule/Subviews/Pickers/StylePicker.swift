//
//  StylePicker.swift
//
//
//  Created by Kevin Hermawan on 26/12/23.
//

import CoreModels
import CoreViews
import SwiftUI

struct StylePicker: View {
    private let styles: [DalleModel.Style]
    @Binding private var selection: DalleModel.Style
    
    init(_ styles: [DalleModel.Style], selection: Binding<DalleModel.Style>) {
        self.styles = styles
        self._selection = selection
    }
    
    var body: some View {
        Section {
            Picker("Select style", selection: $selection) {
                ForEach(styles) { style in
                    Text(style.title).tag(style)
                }
            }
        } header: {
            Text("Style")
        } footer: {
            if selection == DalleModel.Style.vivid {
                FootnoteText("FOOTNOTE_STYLE_VIVID")
            } else {
                FootnoteText("FOOTNOTE_STYLE_NATURAL")
            }
        }
    }
}
