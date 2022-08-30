//
//  CFNavigationBarBKView.swift
//  Smartbus_ChiFeng
//
//  Created by 🐲 on 2022/4/11.
//

import UIKit


/*
 *导航栏 中背景图的公共类 - 主要设置导航蓝的 背景颜色
 */
public class CFNavigationBarBKView: UIView {
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = UIColor(hexString: navigation_BKColor)
    }
}
