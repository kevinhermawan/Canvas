//
//  NSImage.swift
//
//
//  Created by Kevin Hermawan on 09/01/24.
//

import Foundation
import SwiftUI

public extension NSImage {
    func write(to url: URL) throws -> Void {
        guard let tiff = self.tiffRepresentation else { return }
        guard let bitmap = NSBitmapImageRep(data: tiff) else { return }
        guard let data = bitmap.representation(using: .png, properties: [:]) else { return }
        
        try data.write(to: url)
    }
}
