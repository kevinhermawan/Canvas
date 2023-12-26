//
//  NumberPicker.swift
//
//
//  Created by Kevin Hermawan on 26/12/23.
//

import CoreViews
import SwiftUI

struct NumberPicker: View {
    private let numbers: [Int]
    @Binding private var selection: Int
    
    init(_ numbers: [Int], selection: Binding<Int>) {
        self.numbers = numbers
        self._selection = selection
    }
    
    var body: some View {
        Section {
            Picker("Select number", selection: $selection) {
                ForEach(numbers, id: \.self) { number in
                    Text(String(number)).tag(number)
                }
            }
        } header: {
            Text("Number")
        } footer: {
            FootnoteText("FOOTNOTE_NUMBER")
        }
    }
}
