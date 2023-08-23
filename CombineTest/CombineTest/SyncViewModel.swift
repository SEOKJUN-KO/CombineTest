//
//  SyncViewModel.swift
//  CombineTest
//
//  Created by Ko Seokjun on 2023/08/22.
//

import SwiftUI

final class SyncViewModel: ObservableObject {
    @Published var time: String = "1"
    @Published public var imageOne: Image = Image("loading")
    @Published public var imageTwo: Image = Image("loading")
    
    init(){
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self] _ in
            self?.time = "\(Date().timeIntervalSince1970)"
        })
    }
    
    
    func loadImage(){
            guard let url = URL(string: "https://dog.ceo/api/breeds/image/random") else { return }
            
            guard let data = try? Data(contentsOf: url) else { return }
            guard let info = try? JSONDecoder().decode(Dog.self, from: data) else { return }
            
            guard let imageUrl = URL(string: info.message) else { return }
            guard let val = try? Data(contentsOf: imageUrl) else { return }
            guard let image = UIImage(data: val) else { return }
            self.imageOne = Image(uiImage: image)
    }
}
