//
//  CFNavigationBarTitleLabel.swift
//  Smartbus_ChiFeng
//
//  Created by 🐲 on 2022/4/11.
//

import UIKit

/*
 *导航栏 中背标题公共类 - 主要设置导航蓝的 标题颜色
 */

public class CFNavigationBarTitleLabel: UILabel {

    public override func layoutSubviews() {
        super.layoutSubviews()
        self.textColor = UIColor(hexString: navigation_TitleColor)
        //navigation_titleColor
    }

    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
