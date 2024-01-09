//
//  LocalFileManager.swift
//  CryptoTracker
//
//  Created by Marvis Ighedosa on 09/01/2024.
//

import Foundation
import SwiftUI

class LocalFileManager {
    static let instance = LocalFileManager()
    private init() { }
    
    func saveImage(image: UIImage, imageName:String, folderName: String) {
        //Create Folder
        createFolderIfNeeded(folderName: folderName)
        
        //get path for Image
        guard
            let data = image.pngData(),
            let url = getURLforImage(imageName: imageName, folderName: folderName)
        
        else {return}
        
        
        do {
            try data.write(to: url)
        } catch let error {
            print("Error saving image. \(error)")
        }
    }
    
    func getImage(imageName:String , folderName:String) -> UIImage? {
        guard let url = getURLforImage(imageName: imageName, folderName: folderName),
              FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        return UIImage(contentsOfFile: url.path)
    }
    
    private func createFolderIfNeeded (folderName: String) {
        guard let url = getURLForFolder(folderName: folderName) else {return}
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch let error {
                print("Error creating Directory. FolderName: \(folderName). \(error)")
            }
        }
    }
        
        private func getURLForFolder(folderName: String) -> URL? {
            guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
                return nil
            }
            return url.appendingPathComponent(folderName)
        }
        
        private func getURLforImage (imageName: String, folderName: String) -> URL? {
            guard let folderURL = getURLForFolder(folderName: folderName) else {
                return nil
            }
            
            return folderURL.appendingPathComponent(imageName + ".png")
        }
        
    
}
