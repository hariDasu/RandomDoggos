//
//  DogBreedCollectionViewCell.swift
//  STIDogs
//
//  Created by Hari Rao on 6/16/19.
//  Copyright © 2019 hariDasu. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class DogBreedCollectionViewCell: UICollectionViewCell {
    var imageView: UIImageView!
    var imgUrl = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        contentView.addSubview(imageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var frame = imageView.frame
        frame.size.height = 200
        frame.size.width = 200
        frame.origin.x = 0
        frame.origin.y = 0
        imageView.frame = frame
        imageView.sd_setImage(with: URL(string: self.imgUrl), placeholderImage: UIImage(named: "americanDoggo"))
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
