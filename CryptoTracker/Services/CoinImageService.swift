//
//  CoinImageService.swift
//  CryptoTracker
//
//  Created by Marvis Ighedosa on 08/01/2024.
//

import Foundation
import Combine
import SwiftUI

class CoinImageService : ObservableObject{
    @Published var image: UIImage?
    private var imageSubscription: AnyCancellable?
    private var coin:CoinModel
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName: String
    
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    
    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
            print("Retrieve image from File Manager")
        } else {
            downLoadCoinIMage()
            print("Donwloading Imaghe now oooo")
        }
    }
    
    private func downLoadCoinIMage() {
        
        guard let url = URL(string: coin.image ?? "") else { return }
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: {[weak self] returnedImage in
                guard let self = self, let donwloadedIMage = returnedImage else { return }
                self.image = donwloadedIMage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: donwloadedIMage, imageName: self.imageName, folderName: self.folderName)
            })
    }
    
    
}
