//
//  CFBaseNavViewController.swift
//  Smartbus_ChiFeng
//
//  Created by 🐲 on 2022/4/25.
//

import UIKit

public class CFBaseNavViewController: UINavigationController {

    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        if #available(iOS 13.0, *) {
                let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
                 appearance.backgroundColor =  UIColor(hexString: payBtn_BKColor)
                 //设置取消按钮的字
                appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(hexString: payBtn_TextColor)]
                navigationBar.standardAppearance = appearance
                navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        } else {
                UINavigationBar.appearance().barTintColor = UIColor(hexString: payBtn_BKColor)
                UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(hexString: payBtn_TextColor)]
                UINavigationBar.appearance().tintColor = .white
        }
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationBar.isHidden = true
        
    }
    
    public override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if !viewController.isKind(of: McMcTabBarViewController.classForCoder()) {
//            if  viewController.isKind(of: CFLoginViewController.classForCoder())
//            {
//                self.interactivePopGestureRecognizer?.isEnabled = false
//            }else{
//                self.interactivePopGestureRecognizer?.isEnabled = true
//            }

            let vc = viewController
            vc.hidesBottomBarWhenPushed = true
            super.pushViewController(vc, animated: animated)
        }else{
            self.interactivePopGestureRecognizer?.isEnabled = false
            super.pushViewController(viewController, animated: animated)
        }
    }

}
