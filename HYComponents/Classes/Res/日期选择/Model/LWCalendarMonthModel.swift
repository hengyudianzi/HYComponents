//
//  LWMothModel.swift
//  HYBusCustom
//
//  Created by sdhy on 2019/10/24.
//  Copyright © 2019年 sdhy. All rights reserved.
//

import UIKit

class LWCalendarMonth: NSObject{
  
    var firstDay:LWCalendarDay?//第一天
    var lastDay:LWCalendarDay?//最后一天
    var dayNum = 0
    var yearMonthStr:String = ""
    var days = [LWCalendarDay]()
    
    lazy var nextMoth:LWCalendarMonth =  {
        if firstDay?.date == nil{
            return LWCalendarMonth.init()
        }
        let nextDate = LWCalendarManager.getNextMonthDate(date:(firstDay?.date)!)
       
        let month = LWCalendarMonth.init(date:nextDate )
        return month
    }()
    
    lazy var lastMoth:LWCalendarMonth = {
        if firstDay?.date == nil{
            return LWCalendarMonth.init()
        }
        let lastDate = LWCalendarManager.getLastMonthDate(date: (firstDay?.date)!)
        let month = LWCalendarMonth.init(date:lastDate)
        return month
    }()
    init(date:Date=Date.init()) {
        super.init()
        initDays(date: date)
    }
    
    fileprivate func initDays(date:Date)  {
        days.removeAll()
        let dates = LWCalendarManager.getMonthDates(of: date)
        printLog(message: dates)
        dayNum = dates.count
        
        for date in dates {
            
//            let dateStr = date.toString(format: "yyyy-MM-dd HH:mm:ss")
            let dateStr = date.dateString(dateFormatterModel: "dd")
            let week = LWCalendarManager.getWeekDay(of: date)
            let day = LWCalendarDay.init(date: date, dateStr: dateStr, weekStr: week.week, weekIndex: week.index)
            days.append(day)
        }
       
        firstDay = days.first
        lastDay = days.last
        yearMonthStr = firstDay?.date?.yearMonth() ?? ""
       
    }
    
}

class LWCalendarDay: NSObject{
    var date:Date?
    var dateStr:String?
    var weekStr:String?
    var weekIndex:Int?
    
    init( date:Date, dateStr:String,weekStr:String,weekIndex:Int) {
        self.date = date
        self.dateStr = dateStr
        self.weekStr = weekStr
        self.weekIndex = weekIndex
        
    }
    
}
