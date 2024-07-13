//
//  Defaults+Keys.swift
//  Canvas
//
//  Created by Kevin Hermawan on 25/12/23.
//

import CoreModels
import Defaults
import Foundation

extension Defaults.Keys {
    static let ig_selectedModel = Key<DalleModel>("ig_selectedModel", default: .dalle2)
    static let ig_selectedNumber = Key<Int>("ig_selectedNumber", default: DalleModel.dalle2.numbers[0])
    static let ig_selectedSize = Key<DalleModel.Size>("ig_selectedSize", default: ._1024)
    static let ig_selectedQuality = Key<DalleModel.Quality?>("ig_selectedQuality", default: .standard)
    static let ig_selectedStyle = Key<DalleModel.Style?>("ig_selectedStyle", default: .vivid)
    
    static let ie_selectedNumber = Key<Int>("ie_selectedNumber", default: DalleModel.dalle2.numbers[0])
    static let ie_selectedSize = Key<DalleModel.Size>("ie_selectedSize", default: ._1024)
    
    static let iv_selectedNumber = Key<Int>("iv_selectedNumber", default: DalleModel.dalle2.numbers[0])
    static let iv_selectedSize = Key<DalleModel.Size>("iv_selectedSize", default: ._1024)
}
