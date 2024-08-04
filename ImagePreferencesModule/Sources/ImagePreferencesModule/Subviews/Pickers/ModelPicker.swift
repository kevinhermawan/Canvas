//
//  ModelPicker.swift
//
//
//  Created by Kevin Hermawan on 26/12/23.
//

import CoreModels
import CoreViews
import SwiftUI

struct ModelPicker: View {
    @Binding var selection: DalleModel
    
    var body: some View {
        Section {
            Picker("Selected model", selection: $selection) {
                ForEach(DalleModel.allCases) { model in
                    Text(model.title).tag(model)
                }
            }
        } header: {
            Text("Model")
        } footer: {
            FootnoteText("FOOTNOTE_MODEL")
        }
    }
}
