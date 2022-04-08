//
//  DownloadManager.swift
//  Created by Asad Hayat on 10/03/2022.
//
//

import Foundation
import UIKit

final class DownloadManager {
    
    private init(){}
    static let shared = DownloadManager()
    
    func downloadImage(from url:URL, completion: @escaping (UIImage?) -> Void){
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: url){
                if let image = UIImage.init(data: imageData){
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
            }
        }
    }
}
