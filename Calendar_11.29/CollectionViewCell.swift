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
    var collectionViewButton = CustomButton()
    
    @IBOutlet weak var collectionViewButtons: UIButton!
    @IBAction func colletionViewButtons(_ sender: Any) {
    }

    
    // 버튼을 그리는 위치와 프레임을 정하지 않았다.
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(collectionViewButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addSubview(collectionViewButton)
    
     }
    @IBAction func ButtonTest(_ sender: Any) {
    }
    
    //var collectionViewButton = CustomButton()
    //self.view.addSubview(collectionViewButton)
        //.self.addSubview(collectionVIewButton)

    @IBOutlet weak var collectionViewTest: UILabel!
    
    var selectedIndex = 0 
    
    
}
