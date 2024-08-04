//
//  ImagePreferencesView.swift
//
//
//  Created by Kevin Hermawan on 25/12/23.
//

import CoreExtensions
import CoreModels
import CoreViewModels
import CoreViews
import SwiftUI
import ViewCondition

public struct ImagePreferencesView: View {
    private var isModelPickerHidden: Bool = false
    private var isImagePickerVisible: Bool = false
    private var isMaskPickerVisible: Bool = false
    private var imageFootnote: LocalizedStringKey = ""
    private var maskFootnote: LocalizedStringKey = ""
    
    @Binding private var modelSelection: DalleModel
    @Binding private var numberSelection: Int
    @Binding private var sizeSelection: DalleModel.Size
    @Binding private var qualitySelection: DalleModel.Quality?
    @Binding private var styleSelection: DalleModel.Style?
    @Binding private var imageData: Data?
    @Binding private var maskData: Data?
    
    @State private var imageError: Error? = nil
    @State private var maskError: Error? = nil
    
    public init(
        modelSelection: Binding<DalleModel>,
        numberSelection: Binding<Int>,
        sizeSelection: Binding<DalleModel.Size>,
        qualitySelection: Binding<DalleModel.Quality?>,
        styleSelection: Binding<DalleModel.Style?>,
        imageData: Binding<Data?>,
        maskData: Binding<Data?>
    ) {
        self._modelSelection = modelSelection
        self._numberSelection = numberSelection
        self._sizeSelection = sizeSelection
        self._qualitySelection = qualitySelection
        self._styleSelection = styleSelection
        self._imageData = imageData
        self._maskData = maskData
    }
    
    public var body: some View {
        Form {
            ModelPicker(selection: $modelSelection)
                .hide(if: isModelPickerHidden, removeCompletely: true)
            
            ImagePicker("Image", data: $imageData, error: $imageError)
                .footnote(imageFootnote)
                .visible(if: isImagePickerVisible, removeCompletely: true)
            
            ImagePicker("Mask", data: $maskData, error: $maskError)
                .footnote(maskFootnote)
                .visible(if: isMaskPickerVisible, removeCompletely: true)
            
            NumberPicker(modelSelection.numbers, selection: $numberSelection)
                .visible(if: modelSelection.numbers.contains(numberSelection), removeCompletely: true)
            
            SizePicker(modelSelection.sizes, selection: $sizeSelection)
                .visible(if: modelSelection.sizes.contains(sizeSelection), removeCompletely: true)

            if let qualities = modelSelection.qualities, let selection = Binding($qualitySelection) {
                QualityPicker(qualities, selection: selection)
            }
            
            if let styles = modelSelection.styles, let selection = Binding($styleSelection) {
                StylePicker(styles, selection: selection)
            }
        }
        .inspectorColumnWidth(min: 320, ideal: 320)
        .onChange(of: modelSelection) {
            numberSelection = modelSelection.numbers[0]
            sizeSelection = modelSelection.sizes[0]
            qualitySelection = modelSelection.qualities?.first ?? .standard
            styleSelection = modelSelection.styles?.first ?? .vivid
        }
    }
    
    public func modelPickerHidden() -> ImagePreferencesView {
        var view = self
        view.isModelPickerHidden = true
        
        return view
    }
    
    public func imagePickerVisible(text: LocalizedStringKey) -> ImagePreferencesView {
        var view = self
        view.isImagePickerVisible = true
        view.imageFootnote = text
        
        return view
    }
    
    public func maskPickerVisible(text: LocalizedStringKey) -> ImagePreferencesView {
        var view = self
        view.isMaskPickerVisible = true
        view.maskFootnote = text
        
        return view
    }
}
