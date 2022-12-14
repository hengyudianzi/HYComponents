//
//  CFTableView.swift
//  Smartbus_ChiFeng
//
//  Created by π² on 2022/4/9.
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
            //δΈζ ε·ζ°
            self.headerBlock?()
        })

        self.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            //δΈζ ε·ζ°
            self.footerBlock?()
        })
        
    }

    //ιθ - δΈζεδΈζ
    public func endRefreshingTV(_ isNotMore:Bool = false) {
        
        self.mj_header?.endRefreshing()
        self.mj_footer?.endRefreshing()
        if isNotMore {
            self.mj_footer?.endRefreshingWithNoMoreData()
        }
    }

}

