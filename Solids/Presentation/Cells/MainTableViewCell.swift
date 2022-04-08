//
//  MainTableViewCell.swift
//
//  Created by Asad Hayat on 09/03/2022.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    // Outlets
    
    @IBOutlet weak var iconImageView: LazyImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // Properties
    
    var article:Article?{
        didSet{
            guard let article = article else { return }
            titleLabel.text = article.title ?? ""
            dateLabel.text = DateHelper().getDate(from: article.dateTime ?? "")
            if let imageData = article.imageData{
                iconImageView.image = UIImage.init(data: imageData)
            }
            else if let image = article.image{
                if let url = URL.init(string: image){
                    iconImageView.loadImage(from: url)
                }
            }
            if let content = article.content.first{
                descriptionLabel.text = content.description
            }
            else if let ingress = article.ingress{
                descriptionLabel.text = ingress
            }
            else{
                descriptionLabel.text = article.descrip ?? ""
            }
        }
    }
}
