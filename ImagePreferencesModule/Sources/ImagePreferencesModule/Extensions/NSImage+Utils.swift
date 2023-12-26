//
//  NSImage+Utils.swift
//
//
//  Created by Kevin Hermawan on 26/12/23.
//

import Cocoa
import UniformTypeIdentifiers

extension NSImage {
    var isValidPNG: Bool {
        guard let cgImage = self.cgImage(forProposedRect: nil, context: nil, hints: nil) else {
            return false
        }
        
        let data = NSMutableData()
        
        if let destination = CGImageDestinationCreateWithData(data, UTType.png.identifier as CFString, 1, nil) {
            CGImageDestinationAddImage(destination, cgImage, nil)
            
            if CGImageDestinationFinalize(destination) {
                let pngSignature: [UInt8] = [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A]
                let imageDataBytes = [UInt8](data.prefix(8))
                
                return imageDataBytes == pngSignature
            }
        }
        
        return false
    }
    
    var isSquare: Bool {
        guard let primaryRepresentation = self.representations.first else { return false }
        
        return primaryRepresentation.size.width == primaryRepresentation.size.height
    }
    
    func isLargerThan(maxSizeInMB: Double) -> Bool {
        guard let tiffRepresentation = self.tiffRepresentation,
              let bitmapImage = NSBitmapImageRep(data: tiffRepresentation) else {
            return false
        }
        
        guard let imageData = bitmapImage.representation(using: .png, properties: [:]) else {
            return false
        }
        
        let imageSizeInMB = Double(imageData.count) / (1024.0 * 1024.0)
        
        return imageSizeInMB > maxSizeInMB
    }
}
