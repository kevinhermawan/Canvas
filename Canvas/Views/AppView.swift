//
//  AppView.swift
//  Canvas
//
//  Created by Kevin Hermawan on 25/12/23.
//

import CoreModels
import Defaults
import ImageEditModule
import ImageGenerationModule
import ImagePreferencesModule
import ImageVariationModule
import ModelPricingModule
import SwiftUI

struct AppView: View {
    @State private var selectedSidebar: AppSidebarItem = .imageGeneration
    @State private var imagePreferencesPresented: Bool = true
    
    @Default(.ig_selectedModel) private var ig_selectedModel
    @Default(.ig_selectedNumber) private var ig_selectedNumber
    @Default(.ig_selectedSize) private var ig_selectedSize
    @Default(.ig_selectedQuality) private var ig_selectedQuality
    @Default(.ig_selectedStyle) private var ig_selectedStyle
    
    @Default(.ie_selectedNumber) private var ie_selectedNumber
    @Default(.ie_selectedSize) private var ie_selectedSize
    @State private var ie_imageData: Data? = nil
    @State private var ie_maskData: Data? = nil
    
    @Default(.iv_selectedNumber) private var iv_selectedNumber
    @Default(.iv_selectedSize) private var iv_selectedSize
    @State private var iv_imageData: Data? = nil
    
    var body: some View {
        NavigationSplitView {
            AppSidebarView(selection: $selectedSidebar)
                .navigationSplitViewColumnWidth(min: 224, ideal: 224)
        } detail: {
            switch selectedSidebar {
            case .imageGeneration:
                ImageGenerationView(
                    model: ig_selectedModel,
                    number: ig_selectedNumber,
                    size: ig_selectedSize,
                    quality: ig_selectedQuality,
                    style: ig_selectedStyle
                )
                .navigationSubtitle(ig_selectedModel.title)
                .toolbar { PreferencesToolbar() }
                .inspector(isPresented: $imagePreferencesPresented) {
                    ImagePreferencesView(
                        modelSelection: $ig_selectedModel,
                        numberSelection: $ig_selectedNumber,
                        sizeSelection: $ig_selectedSize,
                        qualitySelection: $ig_selectedQuality,
                        styleSelection: $ig_selectedStyle,
                        imageData: .constant(nil),
                        maskData: .constant(nil)
                    )
                }
            case .imageEdit:
                ImageEditView(
                    number: ie_selectedNumber,
                    size: ie_selectedSize,
                    imageData: ie_imageData,
                    maskData: ie_maskData
                )
                .navigationSubtitle(DalleModel.dalle2.title)
                .toolbar { PreferencesToolbar() }
                .inspector(isPresented: $imagePreferencesPresented) {
                    ImagePreferencesView(
                        modelSelection: .constant(.dalle2),
                        numberSelection: $ie_selectedNumber,
                        sizeSelection: $ie_selectedSize,
                        qualitySelection: .constant(nil),
                        styleSelection: .constant(nil),
                        imageData: $ie_imageData,
                        maskData: $ie_maskData
                    )
                    .modelPickerHidden()
                    .imagePickerVisible(text: "FOOTNOTE_IMAGE_IMAGE_EDIT")
                    .maskPickerVisible(text: "FOOTNOTE_MASK_IMAGE_EDIT")
                }
            case .imageVariation:
                ImageVariationView(
                    number: iv_selectedNumber,
                    size: iv_selectedSize,
                    imageData: iv_imageData
                )
                .navigationSubtitle(DalleModel.dalle2.title)
                .toolbar { PreferencesToolbar() }
                .inspector(isPresented: $imagePreferencesPresented) {
                    ImagePreferencesView(
                        modelSelection: .constant(.dalle2),
                        numberSelection: $iv_selectedNumber,
                        sizeSelection: $iv_selectedSize,
                        qualitySelection: .constant(nil),
                        styleSelection: .constant(nil),
                        imageData: $iv_imageData,
                        maskData: .constant(nil)
                    )
                    .modelPickerHidden()
                    .imagePickerVisible(text: "FOOTNOTE_IMAGE_IMAGE_VARIATION")
                }
            case .modelPricing:
                ModelPricingView()
            }
        }
    }
    
    @ViewBuilder
    private func PreferencesToolbar() -> some View {
        Button("Preferences", systemImage: "sidebar.right") {
            imagePreferencesPresented.toggle()
        }
    }
}
