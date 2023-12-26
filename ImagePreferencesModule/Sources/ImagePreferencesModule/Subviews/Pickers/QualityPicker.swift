//
//  QualityPicker.swift
//
//
//  Created by Kevin Hermawan on 26/12/23.
//

import CoreModels
import CoreViews
import SwiftUI

struct QualityPicker: View {
    private let qualities: [DalleModel.Quality]
    @Binding private var selection: DalleModel.Quality
    
    init(_ qualities: [DalleModel.Quality], selection: Binding<DalleModel.Quality>) {
        self.qualities = qualities
        self._selection = selection
    }
    
    var body: some View {
        Section {
            Picker("Select quality", selection: $selection) {
                ForEach(qualities) { quality in
                    Text(quality.title).tag(quality)
                }
            }
        } header: {
            Text("Quality")
        } footer: {
            if selection == DalleModel.Quality.hd {
                FootnoteText("FOOTNOTE_QUALITY_HD")
            } else {
                FootnoteText("FOOTNOTE_QUALITY_STANDARD")
            }
        }
    }
}
