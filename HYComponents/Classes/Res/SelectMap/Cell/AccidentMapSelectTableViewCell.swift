//
//  AccidentMapSelectTableViewCell.swift
//  Smartbus_ChiFeng
//
//  Created by 🐲 on 2022/3/29.
//

import UIKit

class AccidentMapSelectTableViewCell: UITableViewCell {

    @IBOutlet weak var selectImage: UIImageView! //图片
    @IBOutlet weak var subLabel: UILabel!//描述
    @IBOutlet weak var titleLab: UILabel! //标题
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
