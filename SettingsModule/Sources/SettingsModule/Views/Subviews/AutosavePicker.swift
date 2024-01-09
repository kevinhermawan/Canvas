//
//  AutosavePicker.swift
//
//
//  Created by Kevin Hermawan on 09/01/24.
//

import SwiftUI
import ViewCondition

struct AutosavePicker: View {
    @Binding private var enabled: Bool
    @Binding private var location: URL
    private var action: () -> Void
    
    public init(enabled: Binding<Bool>, location: Binding<URL>, action: @escaping () -> Void) {
        self._enabled = enabled
        self._location = location
        self.action = action
    }
    
    private var disabled: Bool {
        enabled == false
    }
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Auto-save Results")
                    .font(.headline.weight(.semibold))
                
                Spacer()
                
                Toggle("", isOn: $enabled)
                    .toggleStyle(.switch)
                    .labelsHidden()
            }
            
            HStack {
                Text(location.path)
                    .if(disabled) { view in
                        view.foregroundStyle(.tertiary)
                    }
                
                Spacer()
                
                Button(action: action) {
                    Image(systemName: "folder")
                }
                .disabled(disabled)
                .help("Choose directory")
            }
        }
        .padding(4)
    }
}
