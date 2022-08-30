//
//  LWCalendarManager.swift
//  HYBusCustom
//
//  Created by sdhy on 2019/10/24.
//  Copyright © 2019年 sdhy. All rights reserved.
//

import UIKit

public class LWCalendarManager: NSObject {
    
    public class func getMonthDates(of date:Date) -> [Date] {
        var dates = [Date]()
        let num = getMonthDaysNum(of: date)
        let calendar = Calendar.current
       
        var comps = DateComponents()
        comps.year = date.year()
        comps.month = date.month()
        
        printLog(message: comps.year)
        printLog(message: comps.month)
        for i in 1 ..< (num+1) {
            comps.day = i
            let monthDate = calendar.date(from: comps)!
            dates.append(monthDate)
        }
       
        return dates
    }
    
    class func getLastMonthDates(of date:Date) -> [Date] {
       
       return getMonthDates(of: getLastMonthDate(date: date))
    }
    class func getNextMonthDates(of date:Date) -> [Date] {
        return getMonthDates(of: getNextMonthDate(date: date))
    }
    // 根据date获取当月天数
    class func getMonthDaysNum(of date:Date) -> Int {
        let calendar = Calendar.current
        let range = calendar.range(of: Calendar.Component.day, in: Calendar.Component.month, for: date)
        return range!.count
    }
    //根据date获取是周几
   class func getWeekDay(of date: Date) -> (week:String,index:Int) {
        let calendar = Calendar.current
        let dateComponets = calendar.dateComponents([Calendar.Component.year,Calendar.Component.month,Calendar.Component.weekday,Calendar.Component.day], from: date)
        //获取到今天是周几 1(星期天) 2(星期一) 3(星期二) 4(星期三) 5(星期四) 6(星期五) 7(星期六)
        let weekDay = dateComponets.weekday
        var weekStr = ""
        var weekIndex = -1
        switch weekDay {
        case 1:
            weekStr = "星期天"
        case 2:
            weekStr =  "星期一"
        case 3:
           weekStr = "星期二"
        case 4:
            weekStr = "星期三"
        case 5:
            weekStr = "星期四"
        case 6:
           weekStr = "星期五"
        case 7:
           weekStr = "星期六"
        default:
           weekStr = ""
            
        }
        weekIndex = weekDay! - 1
        return (weekStr,weekIndex)
    }
    /// 获取距离当前日期，几年几月几日的日期
    ///
    /// - Parameters:
    ///   - year: 距离当前日期的前/后几年  如：去年:-1   明年:1  今年:0
    ///   - month:  距离当前日期的前/后几个月  如：上个月:-1   下个月:1  这个月:0
    ///   - day:  距离当前日期的前/后几天 如：昨天:-1   明天:1   今天:0
    /// - Returns: 返回所要的日期
    class func getDate(to date:Date,year:Int,month:Int,day:Int)->Date {
        let current = date
        let calendar = Calendar(identifier: .gregorian)
        var comps:DateComponents?
        
        comps = calendar.dateComponents([.year,.month,.day], from: current)
        comps?.year = year
        comps?.month = month
        comps?.day = day
        return calendar.date(byAdding: comps!, to: current) ?? Date()
    }
    
    class func getLastMonthDate(date:Date) -> Date {
    
         return getDate(to: date, year: 0, month: -1, day: 0)
    }
    
    class func getNextMonthDate(date:Date) -> Date {
        
        return getDate(to: date, year: 0, month: 1, day: 0)
    }

}
/**
 *  NSCalendarIdentifierGregorian         公历
 NSCalendarIdentifierBuddhist          佛教日历
 NSCalendarIdentifierChinese           中国农历
 NSCalendarIdentifierHebrew            希伯来日历
 NSCalendarIdentifierIslamic           伊斯兰日历
 NSCalendarIdentifierIslamicCivil      伊斯兰教日历
 NSCalendarIdentifierJapanese          日本日历
 NSCalendarIdentifierRepublicOfChina   中华民国日历（台湾）
 NSCalendarIdentifierPersian           波斯历
 NSCalendarIdentifierIndian            印度日历
 NSCalendarIdentifierISO8601           ISO8601
 */
