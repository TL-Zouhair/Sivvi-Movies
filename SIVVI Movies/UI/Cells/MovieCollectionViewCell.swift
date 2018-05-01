//
//  MovieCollectionViewCell.swift
//  SIVVI Movies
//
//  Created by Zouhair on 5/1/18.
//  Copyright © 2018 Zouhair. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 4.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true;
        
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width:0,height: 2.0)
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false;
        layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.contentView.layer.cornerRadius).cgPath
    }
    
    func setUp(movie:Movie) {
        //title.text = movie.title
        if let poster = movie.posterPath {
            var url = SettingsConstants.imagesBaseURL
            url = url.appendingPathComponent(poster)
            image.kf.indicatorType = .activity
            image.kf.setImage(with: url)
        }
        
    }

}
