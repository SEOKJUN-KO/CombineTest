//
//  CombineViewModel.swift
//  CombineTest
//
//  Created by Ko Seokjun on 2023/08/22.
//

import Combine
import SwiftUI

final class CombineViewModel: ObservableObject {
    @Published var time: String = "0"
    
    @Published public var imageOne: Image = Image("loading")
    @Published public var imageTwo: Image = Image("loading")
    public let clicked = PassthroughSubject<Bool, Never>()
    private let imageOneStr = CurrentValueSubject<String, Never>("https://images.dog.ceo/breeds/germanshepherd/n02106662_3781.jpg")
    private let imageTwoStr = CurrentValueSubject<String, Never>("https://images.dog.ceo/breeds/germanshepherd/n02106662_3781.jpg")
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        Timer.publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: { [weak self] _  in
                self?.time = "\(Date().timeIntervalSince1970)"
            })
            .store(in: &cancellables)
        
        
        self.clicked
            .sink(receiveCompletion: { _ in
            }, receiveValue: { [weak self] _ in
                self?.loadImageUrl()
            })
            .store(in: &cancellables)
        
        self.imageOneStr
            .sink(receiveValue: { [weak self] urlString in
                self?.loadImage(url: urlString, mode: 1)
            })
            .store(in: &cancellables)
        
        self.imageTwoStr
            .sink(receiveValue: { [weak self] urlString in
                self?.loadImage(url: urlString, mode: 2)
            })
            .store(in: &cancellables)
    }
    
    func loadImageUrl(){
        guard let url = URL(string: "https://dog.ceo/api/breeds/image/random") else { return }
        
        URLSession.shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Dog.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { _ in},
                  receiveValue: { [weak self] info in
                self?.imageOneStr.send(info.message)
            })
            .store(in: &cancellables)
        
        URLSession.shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Dog.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { _ in},
                  receiveValue: { [weak self] info in
                self?.imageTwoStr.send(info.message)
            })
            .store(in: &cancellables)
    }
    
    func loadImage(url: String, mode: Int){
        guard let url = URL(string: url) else { return }
        URLSession.shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { [weak self] val in
                guard let image = UIImage(data: val) else { return }
                if(mode == 1){
                    self?.imageOne = Image(uiImage: image)
                }
                else {
                    self?.imageTwo = Image(uiImage: image)
                }
            })
            .store(in: &cancellables)
    }
    
}
