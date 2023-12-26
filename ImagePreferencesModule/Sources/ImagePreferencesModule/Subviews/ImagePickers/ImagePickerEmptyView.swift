//
//  ImagePickerEmptyView.swift
//
//
//  Created by Kevin Hermawan on 26/12/23.
//

import SwiftUI

struct ImagePickerEmptyView: View {
    private var titleKey: LocalizedStringKey
    private var action: (_ data: Data?, _ error: Error?) -> Void
    
    init(_ titleKey: LocalizedStringKey, action: @escaping (_: Data?, _: Error?) -> Void) {
        self.titleKey = titleKey
        self.action = action
    }
    
    var body: some View {
        HStack {
            Text(titleKey)
            
            Spacer()
            
            ImagePickerButton("Choose", action: action)
        }
    }
}
