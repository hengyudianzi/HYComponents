//
//  QRCodeViewController.swift
//  HYComponents_Example
//
//  Created by 🐲 on 2022/8/29.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import HYComponents

class QRCodeViewController: UIViewController {

    @IBOutlet weak var imageV: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let qrCodeImage = QRCodeImageCreate.createQRForString("sdasdadasda", qrImageName: "cloud_icon_wallet")

        imageV.image = qrCodeImage
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
