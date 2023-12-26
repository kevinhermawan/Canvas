//
//  ImagePicker.swift
//
//
//  Created by Kevin Hermawan on 26/12/23.
//

import CoreViews
import SwiftUI

struct ImagePicker: View {
    private let title: String
    private var footnote: LocalizedStringKey? = nil
    
    @Binding private var data: Data?
    @Binding private var error: Error?
    
    init(_ title: String, data: Binding<Data?>, error: Binding<Error?>) {
        self.title = title
        self._data = data
        self._error = error
    }
    
    var body: some View {
        Section {
            if let data {
                ImagePickerPreviewView(data: data)
            } else {
                ImagePickerEmptyView("No \(title)") { data, error in
                    self.data = data
                    self.error = error
                }
            }
        } header: {
            SectionHeader(LocalizedStringKey(title))
                .if(data.isNotNil) { view in
                    view.action("Remove", action: { data = nil })
                }
        } footer: {
            if let errorMessage = error?.localizedDescription {
                FootnoteText(LocalizedStringKey(errorMessage))
                    .foregroundStyle(.red)
            } else if let footnote {
                FootnoteText(footnote)
            }
        }
    }
    
    func footnote(_ note: LocalizedStringKey) -> ImagePicker {
        var view = self
        view.footnote = note
        
        return view
    }
}
