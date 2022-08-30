//
//  CFPayButton.swift
//  Smartbus_ChiFeng
//
//  Created by 🐲 on 2022/4/28.
//

import UIKit

public class CFPayButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    public override func draw(_ rect: CGRect) {
        // Drawing code
        
        setBuyButtonColor()
    }
    
    public func setBuyButtonColor() {
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        //未点击
        self.backgroundColor = UIColor(hexString: payBtn_BKColor)
        self.titleLabel?.textColor =  UIColor(hexString: payBtn_TextColor)
        self.setTitleColor(UIColor(hexString: payBtn_TextColor), for: .normal)
    }
}
