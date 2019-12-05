//
//  CollectionViewCell.swift
//  Calendar_11.29
//
//  Created by 조우현 on 2019/11/29.
//  Copyright © 2019 조우현. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    //var CollectionItems = [String]()
    @IBAction func ButtonTest(_ sender: Any) {
    }
    
    var collectionViewButton = CustomButton(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 100, height: 100)))
    
    
    
    @IBOutlet weak var collectionViewTest: UILabel!
    
    var selectedIndex = 0 
    
    
}
