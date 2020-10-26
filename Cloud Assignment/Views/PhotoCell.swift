//
//  ImageCollectionViewCell.swift
//  Cloud Assignment
//
//  Created by tantsunsin on 2020/10/21.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var aIView: UIActivityIndicatorView!
    

    
    var photoForShow : Photo?{
        didSet{
            viewModel = PhotoViewModel(Photo: photoForShow!)
        }
    }

    var viewModel : PhotoViewModel?

    func configure(){

        let ImageUrlString = photoForShow!.thumbnailUrl

        self.idLabel.text = viewModel!.id
        self.titleLabel.text = viewModel!.title


        self.aIView.startAnimating()
        self.aIView.isHidden = false

        self.imageView.image = nil

        viewModel!.getImage(urlString: viewModel!.thumbnailUrl) { (imageGot) in
            guard let imageGot = imageGot else {return}
            DispatchQueue.main.async {
                if ImageUrlString == self.photoForShow!.thumbnailUrl{
                        self.imageView.image = imageGot
                        self.aIView.isHidden = true
                }
            }
        }

    }


}
