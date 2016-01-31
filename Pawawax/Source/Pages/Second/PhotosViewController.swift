//
//  PhotosViewController.swift
//  Pawawax
//
//  Created by Simon Støvring on 31/01/2016.
//  Copyright © 2016 SimonBS. All rights reserved.
//

import Foundation
import UIKit

class PhotosViewController: UICollectionViewController {
    private static let CellIdentifier = "Cel"
    
    private let items: [ImageItem] = {
        return [
            ImageItem(image: UIImage(named: "paris-album-1")!, title: "Notre Dame"),
            ImageItem(image: UIImage(named: "paris-album-2")!, title: "Louvre"),
            ImageItem(image: UIImage(named: "paris-album-3")!, title: "Sunset"),
            ImageItem(image: UIImage(named: "paris-album-4")!, title: "View from Tour Eiffel"),
            ImageItem(image: UIImage(named: "paris-album-5")!, title: "Arc de Triomphe"),
            ImageItem(image: UIImage(named: "paris-album-6")!, title: "Disneyland"),
            ImageItem(image: UIImage(named: "paris-album-7")!, title: "Versailles")
        ]
    }()
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(400, 400)
        layout.scrollDirection = .Horizontal
        layout.minimumLineSpacing = 60
        super.init(collectionViewLayout: layout)
        collectionView?.clipsToBounds = false
        collectionView?.contentInset = UIEdgeInsetsMake(0, 90, 0, 90)
        collectionView?.registerClass(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotosViewController.CellIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCellWithReuseIdentifier(PhotosViewController.CellIdentifier, forIndexPath: indexPath)
    }
    
    override func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        guard let cell = cell as? PhotoCollectionViewCell else { return }
        cell.vacationView.imageView.image = items[indexPath.item].image
        cell.vacationView.titleLabel.text = items[indexPath.item].title.uppercaseString
    }
}

private struct ImageItem {
    let image: UIImage
    let title: String
}