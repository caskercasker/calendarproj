//
//  CustomButton.swift
//  Calendar_11.29
//
//  Created by 조우현 on 12/5/19.
//  Copyright © 2019 조우현. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect)  {
        super.init(frame:frame)
        setupButton()
    }
     
     required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
     }
    
    
    func setupButton(){
        setShadow()
            setTitleColor(.red, for: .normal)
            
            backgroundColor      = .red
            titleLabel?.font     = UIFont(name: "AvenirNext-DemiBold", size: 18)
            layer.cornerRadius   = 25
            layer.borderWidth    = 3.0
            layer.borderColor    = UIColor.darkGray.cgColor
        }
        
        
        private func setShadow() {
            layer.shadowColor   = UIColor.black.cgColor
            layer.shadowOffset  = CGSize(width: 0.0, height: 6.0)
            layer.shadowRadius  = 8
            layer.shadowOpacity = 0.5
            clipsToBounds       = true
            layer.masksToBounds = false
        }
        
    
    }
    /*
     // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */


