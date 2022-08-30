//
//  CFTicketCalendarView.swift
//  Smartbus_ChiFeng
//
//  Created by 🐲 on 2022/6/1.
//

import UIKit
import SnapKit
import HandyJSON

public struct CFTicketCalendarListModel: HandyJSON {
    public init() {
        
    }
    var dateTime:String?
    var ticketNumber : String?
    var isSelect : Bool?
}


public typealias CFTicketCalendarViewBlock = (_ selectlist:[CFTicketCalendarListModel]?,_ totalList:[CFTicketCalendarListModel]?)->Void
public typealias CFTicketCalendarSelectMonthBlock = (_ monthStr:String)->Void


public class CFTicketCalendarView: UIView {
    
    @IBOutlet weak var bkView: UIView!
    //当前日期 - view
    @IBOutlet weak var bottomLineLabel: UILabel!
    
    public var calendarListArray : [CFTicketCalendarListModel]?
    var dateView : LWCalendarSelectView? = {
         let view = LWCalendarSelectView(frame: .zero)
         return view
     }()
    
    public var block:CFTicketCalendarViewBlock?
    public var selectBlock:CFTicketCalendarSelectMonthBlock?
    
    func setData(_ calendarList : [CFTicketCalendarListModel]?,_ isFirst:Bool = true) {
        
        calendarListArray = calendarList
        
        if isFirst {
            bkView.addSubview(dateView!)
            dateView?.snp.makeConstraints { make in
                make.left.right.bottom.equalToSuperview()
                make.top.equalTo(self.bottomLineLabel.safeAreaLayoutGuide.snp.bottom)
            }
        }
        
        dateView?.delegate =  self
        dateView?.reloadCalendarData()
    }
    
    //取消
    @IBAction func cancelAction(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    //确定
    @IBAction func sureAction(_ sender: Any) {
        self.removeFromSuperview()
        
        var list = [CFTicketCalendarListModel]()
        calendarListArray?.forEach({ model in
            if (model.isSelect ?? false) {
                list.append(model)
            }
        })
        block?(list,calendarListArray)
    }
    
}

extension CFTicketCalendarView : LWCalendarSelectViewDelegate{
    
    
    func calendarSelectView(calendarSelectView: LWCalendarSelectView, itemDataReloaded day: LWCalendarDay?, bottomText: String?, item: UIButton, index: Int) {
        
        
        guard ((day?.date) != nil) && (day != nil) else {
            printLog(message: "数据为空")
            return
        }
        
        guard (calendarListArray?.count ?? 0) > 0 else {
            printLog(message: "数据为空")
            return
        }
        let dateStr = day?.date?.toString(format: "yyyy-MM-dd")
        for model in calendarListArray ?? [] {
            if dateStr == model.dateTime {
                let ticketNumber = (model.ticketNumber ?? "0").integerValue()
                calendarSelectView.setItemData(day: day, bottomText: ticketNumber > 0 ? "\(ticketNumber)张":"", button: item)
                item.isSelected = model.isSelect ?? false
            }
        }
        
    }
    
    func calendarSelectView(calendarSelectView: LWCalendarSelectView, didClicked item: UIButton, at index: Int, day: LWCalendarDay?) {
        
        guard ((day?.date) != nil) && (day != nil) else {
            printLog(message: "数据为空")
            return
        }
        
        guard (calendarListArray?.count ?? 0) > 0 else {
            printLog(message: "数据为空")
            return
        }
        
        let dateStr = day?.date?.toString(format: "yyyy-MM-dd")
        printLog(message: dateStr)
        
        var index = 0
        var selectIndex = 0
        for model in calendarListArray ?? [] {
            if dateStr == model.dateTime {
                selectIndex = index
            }
            index += 1
        }
        
        guard selectIndex < (calendarListArray?.count ?? 0) else {
            printLog(message: "点击小")
            return
        }
        var dataModel = calendarListArray![selectIndex]
        dataModel.isSelect = !(dataModel.isSelect ?? false)
        calendarListArray![selectIndex] = dataModel
        
        calendarSelectView.reloadCalendarData()
    }
    
    func calendarTopOrNextMonth(_ monthStr: String) {
        printLog(message: monthStr)
        selectBlock?(monthStr)
    }
    
}
