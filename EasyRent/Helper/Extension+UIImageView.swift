//
//  Extension+UIImageView.swift
//  EasyRent
//
//  Created by Hitesh on 2022-10-27.
//

import UIKit
import SDWebImage

extension UIImageView {
    func loadImageWithIndicator(_ url:String?, placeholder:UIImage?) {
        if let u = url {
            self.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.sd_setImage(with: URL(string: u), placeholderImage: placeholder)
        } else {
            self.image = UIImage()
        }
    }
}


