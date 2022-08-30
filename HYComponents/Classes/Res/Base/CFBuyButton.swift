//
//  CFBuyButton.swift
//  Smartbus_ChiFeng
//
//  Created by 🐲 on 2022/4/27.
//

import UIKit

public class CFBuyButton: UIButton {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    public override func draw(_ rect: CGRect) {
        // Drawing code
        
        setBuyButtonColor(self.frame.height/2)
    }
    
    

}

public class CFBuyButton_Details: UIButton {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    public override func draw(_ rect: CGRect) {
        // Drawing code
        
        setBuyButtonColor(20)
    }
    
    

}


extension UIButton{
    public func setBuyButtonColor(_ radius:CGFloat = 5) {
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
        //未点击
        self.backgroundColor = UIColor(hexString: buyTicketBtn_BKColor)
        self.titleLabel?.textColor =  UIColor(hexString: buyTicketBtn_TextColor)
        self.setTitleColor(UIColor(hexString: buyTicketBtn_TextColor), for: .normal)
    }
}
