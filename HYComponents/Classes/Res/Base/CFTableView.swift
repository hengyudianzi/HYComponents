//
//  CFTableView.swift
//  Smartbus_ChiFeng
//
//  Created by 🐲 on 2022/4/9.
//

import UIKit
import MJRefresh


public typealias CFTableViewBlock = ()->Void

public class CFTableView : UITableView {

    
    public var headerBlock : CFTableViewBlock?
    public var footerBlock : CFTableViewBlock?
    
    public var data : [Any]?{
        didSet{
            layoutSubviews()
        }
    }
    
    public var hiddenFooter : Bool? = true{
        didSet{
            layoutSubviews()
        }
    }
    
    public var hiddenHeader : Bool?{
        didSet{
            layoutSubviews()
        }
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        self.mj_footer?.isHidden = hiddenFooter ?? false
        self.mj_header?.isHidden = hiddenHeader ?? false
    }
    
    public override func draw(_ rect: CGRect) {
        
        self.separatorStyle = .none
        
        self.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            //上拉 刷新
            self.headerBlock?()
        })

        self.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            //下拉 刷新
            self.footerBlock?()
        })
        
    }

    //隐藏 - 上拉和下拉
    public func endRefreshingTV(_ isNotMore:Bool = false) {
        
        self.mj_header?.endRefreshing()
        self.mj_footer?.endRefreshing()
        if isNotMore {
            self.mj_footer?.endRefreshingWithNoMoreData()
        }
    }

}

