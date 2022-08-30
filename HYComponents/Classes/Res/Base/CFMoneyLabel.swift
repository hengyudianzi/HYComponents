//
//  CFMoneyLabel.swift
//  Smartbus_ChiFeng
//
//  Created by 🐲 on 2022/4/28.
//

import UIKit

public class CFMoneyLabel: UILabel {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    public override func draw(_ rect: CGRect) {
        // Drawing code
        self.textColor = UIColor(hexString: money_TextColor)
    }
    

}
