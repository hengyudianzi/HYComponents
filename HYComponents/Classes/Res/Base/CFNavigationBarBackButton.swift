//
//  CFNavigationBarBackButton.swift
//  Smartbus_ChiFeng
//
//  Created by 🐲 on 2022/4/11.
//

import UIKit

/*
 *导航栏 中返回按钮的的公共类 - 暂未用到
 */

public class CFNavigationBarBackButton: UIButton {

    public override func layoutSubviews() {
        super.layoutSubviews()
        self.setBackgroundImage(UIImage(named: ""), for: .normal)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
