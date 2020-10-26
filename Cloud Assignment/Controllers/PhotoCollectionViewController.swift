//
//  ImageCollectionViewController.swift
//  Cloud Assignment
//
//  Created by tantsunsin on 2020/10/21.
//

import UIKit

private let reuseIdentifier = "PhotoCell"

class PhotoCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        aIView.startAnimating()
        configureLayout()
        viewModel.getPhotos {
            self.collectionView.reloadData()
            self.aIView.stopAnimating()
            self.aIView.isHidden = true
        }
        
        let refreshCon = UIRefreshControl()
        let attribute = [NSAttributedString.Key.foregroundColor : UIColor.darkGray]
        refreshCon.attributedTitle = NSAttributedString(string: "重新載入", attributes: attribute)
        refreshCon.addTarget(self, action: #selector(reloadCollectionView), for: .valueChanged)
        collectionView.refreshControl = refreshCon

    }
    
    @IBOutlet weak var aIView: UIActivityIndicatorView!
    
    func configureLayout(){
        let itemSpace : CGFloat = 5
        let columnCount : CGFloat = 4
        let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
        let width = floor((collectionView.bounds.width - itemSpace * (columnCount - 1)) / columnCount)
        flowLayout?.itemSize = CGSize(width: width, height: width)
        flowLayout?.estimatedItemSize = .zero
        flowLayout?.minimumLineSpacing = itemSpace
        flowLayout?.minimumInteritemSpacing = itemSpace
    }

    @objc func reloadCollectionView(){
        DispatchQueue.global(qos: .default).async{
//            self.aIView.startAnimating()
            self.viewModel.getPhotos {
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.aIView.stopAnimating()
                    self.aIView.isHidden = true
                    self.collectionView.refreshControl?.endRefreshing()
                }
            }
        }
    }
    
    var viewModel = CollectionViewModel()

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.PhotoViewModels.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
        cell.photoForShow = photos![indexPath.row]

        cell.configure()
        
        return cell
    }


}
