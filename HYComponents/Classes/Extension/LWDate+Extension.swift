//
//  Date+Extension.swift
//  HYComponents
//
//  Created by 🐲 on 2022/8/29.
//

import Foundation

public  class LWDateFormatterModel: NSObject {
//    PGDatePickerModeYear, //年
//    PGDatePickerModeYearAndMonth, //年月
    public static  let date = "yyyy-MM-dd" //年月日
    public static  let year = "yyyy" //年月日
    public static  let month = "MM" //年月日
    public static  let yearMonth = "yyyy-MM" //年月日
//    PGDatePickerModeDateHour, //年月日时
//    PGDatePickerModeDateHourMinute, //年月日时分
    public static  let dateHourMinuteSecond = "yyyy-MM-dd HH:mm:ss"//年月日时分秒
//    PGDatePickerModeMonthDay, //月日
//    PGDatePickerModeMonthDayHour, //月日时
//    PGDatePickerModeMonthDayHourMinute, //月日时分
//    PGDatePickerModeMonthDayHourMinuteSecond, //月日时分秒
    public static  let time = "HH:mm" //时分
    public static  let timeAndSecond = "HH:mm:ss" //时分秒
//    PGDatePickerModeMinuteAndSecond, //分秒
//    PGDatePickerModeDateAndTime, //月日周 时分
    
}

public  class LWFormatterDate: NSDate {
    
}

extension Date {
    
    public  static func dateString(dateFormatterModel model : String = LWDateFormatterModel.date) -> String {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = model
        let dateStr = dateFormatter.string(from: Date())
        return dateStr
    }
    
  
    
    public static func dateStringOfLastWeek(dateFormatterModel model : String = LWDateFormatterModel.date) -> String {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = model
        let dateStr = dateFormatter.string(from: Date.init(timeIntervalSinceNow: -(7*24*60*60)))
        return dateStr
    }
    
    
    public static func timeAndSecondString() -> String
    {
        return dateString(dateFormatterModel: LWDateFormatterModel.timeAndSecond)
    }
    
    public func dateString(dateFormatterModel model : String = LWDateFormatterModel.date) -> String {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = model
        let dateStr = dateFormatter.string(from: self)
        return dateStr
    }
    public func year() -> String
    {
        return dateString(dateFormatterModel: LWDateFormatterModel.year)
    }
    public func year() -> Int
    {
        let year = NSString.init(string: dateString(dateFormatterModel: LWDateFormatterModel.year))
        return year.integerValue
    }
    public func month() -> Int
    {
        let month = NSString.init(string: dateString(dateFormatterModel: LWDateFormatterModel.month))
        return month.integerValue
    }
    public func yearMonth() -> String
    {
        return dateString(dateFormatterModel: LWDateFormatterModel.yearMonth)
    }
    
    public func week() -> String
    {
        return LWCalendarManager.getWeekDay(of: self).week
    }
}
