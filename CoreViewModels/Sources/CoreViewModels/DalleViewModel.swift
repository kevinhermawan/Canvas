//
//  DalleViewModel.swift
//
//
//  Created by Kevin Hermawan on 25/12/23.
//

import Combine
import Foundation
import OpenAI
import ViewState

@MainActor
@Observable
public final class DalleViewModel {
    private var openAI: OpenAI? = nil
    private var cancellable: AnyCancellable? = nil
    
    public var results: [URL] = []
    public var viewState: ViewState? = nil
    
    public init() {}
    
    public func setup(apiKey: String?) {
        guard let apiKey else { return }
        
        self.openAI = OpenAI(apiToken: apiKey)
    }
    
    public func imageGeneration(query: ImagesQuery) {
        guard let openAI else { return }
        
        self.viewState = .loading
        self.results = []
        
        self.cancellable = openAI.images(query: query)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: self.handleCompletion, receiveValue: { [weak self] result in
                guard let self else { return }
                
                self.handleReceiveResult(result, with: query)
            })
    }
    
    public func imageEdit(query: ImageEditsQuery) {
        guard let openAI else { return }
        
        self.viewState = .loading
        self.results = []
        
        self.cancellable = openAI.imageEdits(query: query)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: self.handleCompletion, receiveValue: { [weak self] result in
                guard let self else { return }
                
                self.handleReceiveResult(result, with: query)
            })
    }
    
    public func imageVariation(query: ImageVariationsQuery) {
        guard let openAI else { return }
        
        self.viewState = .loading
        self.results = []
        
        self.cancellable = openAI.imageVariations(query: query)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: self.handleCompletion, receiveValue: { [weak self] result in
                guard let self else { return }
                
                self.handleReceiveResult(result, with: query)
            })
    }
    
    public func cancel() {
        self.cancellable?.cancel()
        self.viewState = nil
    }
    
    private func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            self.viewState = nil
        case .failure(let error):
            self.viewState = .error(message: error.localizedDescription)
        }
    }
    
    private func handleReceiveResult(_ result: ImagesResult, with query: ImagesQuery) {
        let urls = result.data
            .compactMap({ $0.url })
            .compactMap({ URL(string: $0) })
        
        for url in urls {
            self.results.append(url)
        }
    }
    
    private func handleReceiveResult(_ result: ImagesResult, with query: ImageEditsQuery) {
        let urls = result.data
            .compactMap({ $0.url })
            .compactMap({ URL(string: $0) })
        
        for url in urls {
            self.results.append(url)
        }
    }
    
    private func handleReceiveResult(_ result: ImagesResult, with query: ImageVariationsQuery) {
        let urls = result.data
            .compactMap({ $0.url })
            .compactMap({ URL(string: $0) })
        
        for url in urls {
            self.results.append(url)
        }
    }
}
