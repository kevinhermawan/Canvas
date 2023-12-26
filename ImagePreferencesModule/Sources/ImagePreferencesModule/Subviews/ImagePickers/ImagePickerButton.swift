//
//  ImagePickerButton.swift
//
//
//  Created by Kevin Hermawan on 26/12/23.
//

import SwiftUI

struct ImagePickerButton: View {
    private var titleKey: LocalizedStringKey
    private var action: (_ data: Data?, _ error: Error?) -> Void
    
    @State private var presented: Bool = false
    
    init(_ titleKey: LocalizedStringKey, action: @escaping (_: Data?, _: Error?) -> Void) {
        self.titleKey = titleKey
        self.action = action
    }
    
    var body: some View {
        Button(action: { presented = true }) {
            Label(titleKey, systemImage: "photo.on.rectangle.angled")
        }
        .fileImporter(isPresented: $presented, allowedContentTypes: [.png]) { result in
            switch result {
            case .success(let url):
                if url.startAccessingSecurityScopedResource() {
                    self.process(url: url)
                } else {
                    self.action(nil, ImagePickerError.fileAccessError)
                }
            case .failure(let error):
                self.action(nil, error)
            }
        }
    }
    
    func process(url: URL) {
        do {
            let data = try Data(contentsOf: url)
            let validatedData = try self.validate(data: data)
            url.stopAccessingSecurityScopedResource()
            
            self.action(validatedData, nil)
        } catch {
            self.action(nil, error)
        }
    }
    
    func validate(data: Data) throws -> Data {
        guard let image = NSImage(data: data), image.isValidPNG else {
            throw ImagePickerError.unsupportedImageFormat
        }
        
        guard !image.isLargerThan(maxSizeInMB: 4.0) else {
            throw ImagePickerError.oversizedFile
        }
        
        guard image.isSquare else {
            throw ImagePickerError.nonUniformDimensions
        }
        
        return data
    }
    
    enum ImagePickerError: LocalizedError {
        case fileAccessError, unsupportedImageFormat, oversizedFile, nonUniformDimensions
        
        var errorDescription: String? {
            switch self {
            case .fileAccessError:
                return "There was an error accessing the file."
            case .unsupportedImageFormat:
                return "The image format is not supported."
            case .oversizedFile:
                return "The image exceeds the maximum file size limit."
            case .nonUniformDimensions:
                return "The image dimensions must be a square."
            }
        }
    }
}
