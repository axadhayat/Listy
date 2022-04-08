//
//  LazyImageView.swift
//
//  Created by Asad Hayat on 09/03/2022.
//

import Foundation
import UIKit

class LazyImageView: UIImageView{

    // Cache
    private let imageCache = NSCache<AnyObject, UIImage>()

    func loadImage(from url: URL, placeHolderImage: String = "placeholder-image")
    {
        self.image = UIImage(named: placeHolderImage)
        // Get image from Cache
        if let cachedImage = self.imageCache.object(forKey: url as AnyObject)
        {
            self.image = cachedImage
            return
        }
        
        DownloadManager.shared.downloadImage(from: url) { image in
            guard let image = image else { return }
            // Store image into Cache
            self.imageCache.setObject(image, forKey: url as AnyObject)
            self.image = image
        }
    }
}
