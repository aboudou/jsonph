//
//  AlbumTableViewCell.swift
//  jsonph
//
//  Created by Arnaud Boudou on 20/08/2019.
//  Copyright © 2019 Arnaud Boudou. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class AlbumTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // Inspiration pour le fonctionnement d'une UICollectionView dans une UITableViewCell
    //   https://ashfurrow.com/blog/putting-a-uicollectionview-in-a-uitableviewcell-in-swift/
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet private weak var photosCollectionView: UICollectionView!
    
    private var photoListVM: PhotoListVM?
    
    
    // MARK:- Misc
    func fetchPhotos(for albumId: Int) {
        Api.shared.album_photos(albumId: albumId) { photos, error in
            if let photos = photos {
                self.photoListVM = PhotoListVM(photos: photos)
                DispatchQueue.main.async {
                    self.photosCollectionView.reloadData()
                }
            }
        }
    }
    func setCollectionViewDataSourceDelegate() {
        self.photosCollectionView.delegate = self
        self.photosCollectionView.dataSource = self
    }
    
    // MARK:- UICollectionViewDelegate, UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let photoListVM = self.photoListVM {
            return photoListVM.photos.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath as IndexPath) as? PhotoCollectionViewCell else {
            fatalError("PhotoCollectionViewCell not found")
        }
        
        if let photoListVM = self.photoListVM, let url = URL(string: PhotoCellVM(photoListVM.photos[indexPath.item]).thumbnailUrl) {
            cell.imageView.af_setImage(withURL: url)
        }
        
        return cell
    }
    

}
