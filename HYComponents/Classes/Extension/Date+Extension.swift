//
//  Date+Extension.swift
//  HYComponents
//
//  Created by 🐲 on 2022/8/29.
//

import Foundation


extension Date{
    
    //yyyy-MM-dd HH:mm:ss
    public  static func getCurrentDate(format:String) -> String
    {
        let date = Date()
        let timeFormatter = DateFormatter()
        //(格式可俺按自己需求修整)
        timeFormatter.dateFormat = format
        let strNowTime = timeFormatter.string(from: date as Date) as String
        return strNowTime
    }
    
    
    //MARK: - date 转 字符串
    public func toString(format:String)->String{
        let formatter:DateFormatter = DateFormatter()
        formatter.dateFormat = format
        let str = formatter.string(from: self)
        return str
    }
    
    
    //MARK: - 本周开始日期（星期天）
    public static func startOfThisWeek() -> Date {
        let date = Date()
        let calendar = NSCalendar.current
        let components = calendar.dateComponents(
            Set<Calendar.Component>([.yearForWeekOfYear, .weekOfYear]), from: date)
        let startOfWeek = calendar.date(from: components)!
        return startOfWeek
    }
    
     //MARK: - 本周结束日期（星期六）
    public static func endOfThisWeek(returnEndTime:Bool = false) -> Date {
        let calendar = NSCalendar.current
        var components = DateComponents()
        if returnEndTime {
            components.day = 7
            components.second = -1
        } else {
            components.day = 6
        }
        
        let endOfMonth =  calendar.date(byAdding: components, to: startOfThisWeek())!
        return endOfMonth
    }
    
    //MARK: - 获取某一天所在周一和周日的日期
    public static func getWeekTime(_ dateStr: String) -> Array<String> {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let nowDate = dateFormatter.date(from: dateStr)
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.year, .month, .day, .weekday], from: nowDate!)
        
        // 获取今天是周几
        let weekDay = comp.weekday
        // 获取几天是几号
        let day = comp.day
        
        // 计算当前日期和本周的星期一和星期天相差天数
        var firstDiff: Int
        var lastDiff: Int
        // weekDay = 1;
        if (weekDay == 1) {
            firstDiff = -6;
            lastDiff = 0;
        } else {
            firstDiff = calendar.firstWeekday - weekDay! + 1
            lastDiff = 8 - weekDay!
        }
        
        // 在当前日期(去掉时分秒)基础上加上差的天数
        var firstDayComp = calendar.dateComponents([.year, .month, .day], from: nowDate!)
        firstDayComp.day = day! + firstDiff
        let firstDayOfWeek = calendar.date(from: firstDayComp)
        var lastDayComp = calendar.dateComponents([.year, .month, .day], from: nowDate!)
        lastDayComp.day = day! + lastDiff
        let lastDayOfWeek = calendar.date(from: lastDayComp)
        
        let firstDay = dateFormatter.string(from: firstDayOfWeek!)
        let lastDay = dateFormatter.string(from: lastDayOfWeek!)
        let weekArr = [firstDay, lastDay]
        
        return weekArr;
    }
    
    // MARK: 当月开始日期
    public static func startOfCurrentMonth(_ nowDay: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let nowDayDate = dateFormatter.date(from: nowDay)
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: nowDayDate!)
        let startOfMonth = calendar.date(from: components)
        
        let day = dateFormatter.string(from: startOfMonth!)
        return day
    }
    
    // MARK: 当月结束日期
    public static func endOfCurrentMonth(_ nowDay: String, returnEndTime:Bool = false) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let nowDayDate = dateFormatter.date(from: nowDay)
        
        let calendar = Calendar.current
        var components = DateComponents()
        components.month = 1
        if returnEndTime {
            components.second = -1
        } else {
            components.day = -1
        }
        //startOfCurrentMonth
        let currentMonth = calendar.dateComponents([.year, .month], from: nowDayDate!)
        let startOfMonth = calendar.date(from: currentMonth)
        let endOfMonth = calendar.date(byAdding: components, to: startOfMonth!)
        
        let day = dateFormatter.string(from: endOfMonth!)
        return day
    }
    
    public static func getTwoDateDays(startTime:String,endTime:String) -> NSInteger{
//        let day:NSInteger?
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let date1 = dateFormatter.date(from: startTime)
        let date2 = dateFormatter.date(from: endTime)
        
        guard date1 != nil, date2 != nil else {
            return -1
        }
        
        let components = NSCalendar.current.dateComponents([.day], from: date1!, to: date2!)
        guard components.day != nil else {
            return -1
            
        }
        return components.day!
    }
    
    public static func compareTimeOfSize(startDate:String, endDate:String) -> String{

        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        var data1 = Date()
        var data2 = Date()

        data1 = df.date(from: startDate)!
        data2 = df.date(from: endDate)!
        
        let result:ComparisonResult = data1.compare(data2)
        
        switch result {
        case .orderedAscending:
            //date01比date02 小
            return "-1"
        case .orderedDescending:
            //date01比date02 大
            return "1"
        case .orderedSame:
            //相同
            return "0"
        default:
            return ""
        }
    }
    
    public static func copareTimeOfHour(startTime:String,nowTime:String) -> CGFloat {
        
        var totalHoure:CGFloat = 0
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        var data1 = Date()
        var data2 = Date()

        data1 = df.date(from: startTime)!
        data2 = df.date(from: nowTime)!
        
        //NSCalendar.Unit.CalendarUnitHour
        let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let result2 = gregorian!.components(NSCalendar.Unit.minute, from: data1, to: data2, options: NSCalendar.Options(rawValue: 0))
        let minute:CGFloat = CGFloat(result2.minute ?? 0)
        
        totalHoure =  minute/CGFloat(60) //minute.truncatingRemainder(dividingBy: CGFloat(60)) //Float(minute/60) + Float(num2/60)
        
        print(totalHoure)
        return totalHoure
    }
    
    public static func compareHour(startTime:String,nowTime:String ,success: @escaping (_ hour:String,_ minute:String,_ second:String)->()) {
                
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        var data1 = Date()
        var data2 = Date()

        data1 = df.date(from: startTime)!
        data2 = df.date(from: nowTime)!
        
        //NSCalendar.Unit.CalendarUnitHour
        let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let result1 = gregorian!.components([NSCalendar.Unit.hour,NSCalendar.Unit.minute,NSCalendar.Unit.second], from: data1, to: data2, options: NSCalendar.Options(rawValue: 0))
        
        let hour = result1.hour ?? 0
        let minute = result1.minute ?? 0
        let second = result1.second ?? 0
        
        success(getT(t: hour),getT(t: minute),getT(t: second))
    }
    
    
    public static func getT(t:NSInteger) -> String {
        var hourStr = ""
        let ts = "\(t)".replacingOccurrences(of: "-", with: "")
        if ts.length == 1{
            hourStr = "0\(ts)"
        }else if ts.length == 2 {
            hourStr = "\(ts)"
        }
        return hourStr
    }
    
    public static func getNextYearAndMonth(_ dataStr:String) -> (year:Int,month:Int){
        
//        let dateStr =  self.getCurrentDate(format: "yyyy-mm")
        guard let currentYear = Int(dataStr.split(separator: "-").first ?? "0") else { return (0,0) }
        guard let currentMonth =  Int(dataStr.split(separator: "-").last ?? "0") else { return (0,0) }
        
        var next_year:Int = currentYear
        var next_month:Int = currentMonth + 1
        if (next_month > 12) {
            next_month = 1
            next_year += 1
        }
        //Swift可以同时返回多个值，返回值类型为元组
        return (next_year,next_month)
    }
    
    //每调用一次月份向上跳一月，跨年则为上一年12月
    public static func getPrevYearAndMonth (_ dataStr:String) -> (year:Int,month:Int){
        
//        let dateStr =  self.getCurrentDate(format: "yyyy-mm")
        guard let currentYear = Int(dataStr.split(separator: "-").first ?? "0") else { return (0,0) }
        guard let currentMonth =  Int(dataStr.split(separator: "-").last ?? "0") else { return (0,0) }
        
        var prev_year:Int = currentYear
        var prev_month:Int = currentMonth - 1
        if prev_month == 0 {
            prev_month = 12
            prev_year -= 1
        }
        return (prev_year,prev_month)
    }
    
    
    public static func getFontDaysDate(_ days:Int) -> String{
        let currentDate = NSDate()
        let appointDate:NSDate?
        let oneDay:TimeInterval = 24 * 60 * 60  // 一天一共有多少秒
        appointDate = currentDate.addingTimeInterval(oneDay * Double(days))
        
        let timeFormatter = DateFormatter()
        //(格式可俺按自己需求修整)
        timeFormatter.dateFormat = "yyyy-MM-dd"
        let strNowTime = timeFormatter.string(from: appointDate as! Date) as String
        print(strNowTime)
        
        return strNowTime
    }
    
    //开始事件 和 结束时间 比较大小
    public static func compareTime(_ starStr:String,_ stopStr:String) -> Bool {
        // 其中 starStr， stopStr 为字符串类型，结构类似“2020-01-01”
         
        guard starStr != "" &&  stopStr != "" else {
            return true
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let tempStart = formatter.date(from: starStr)
        let tempStop = formatter.date(from: stopStr)
        let intervalStart = tempStart!.timeIntervalSince1970
        let intervalStop = tempStop!.timeIntervalSince1970
        if intervalStart >  intervalStop {
            showToast("结束时间不能早于开始时间")
            return false
        }
        return true
    }
    
    //MARK: -根据后台时间戳返回几分钟前，几小时前，几天前
    public static func timeStampToCurrennTime(timeStamp: Double) -> String {
        
        //获取当前的时间戳
        let currentTime = Date().timeIntervalSince1970
        //时间戳为毫秒级要 ／ 1000， 秒就不用除1000，参数带没带000
       //let timeSta:TimeInterval = TimeInterval(timeStamp / 1000)
        //时间差
        let reduceTime : TimeInterval = currentTime - timeStamp
        //时间差小于60秒
        if reduceTime < 60 {
            return "刚刚"
        }
        //时间差大于一分钟小于60分钟内
        let mins = Int(reduceTime / 60)
        if mins < 60 {
            return "\(mins)分钟前"
        }
        //时间差大于一小时小于24小时内
        let hours = Int(reduceTime / 3600)
        if hours < 24 {
            return "\(hours)小时前"
        }
        //时间差大于一天小于30天内
        let days = Int(reduceTime / 3600 / 24)
        if days < 30 {
            return "\(days)天前"
        }
        //不满足以上条件直接返回日期
        let date = NSDate(timeIntervalSince1970: timeStamp)
        let dfmatter = DateFormatter()
        //yyyy-MM-dd HH:mm:ss
        dfmatter.dateFormat="yyyy年MM月dd日 HH:mm:ss"
        return dfmatter.string(from: date as Date)
    }

    //时间戳转成字符串
    public static func timeIntervalChangeToTimeStr(timeInterval:Double, _ dateFormat:String? = "yyyy-MM-dd HH:mm:ss") -> String {
        let date:Date = Date.init(timeIntervalSince1970: timeInterval)
        let formatter = DateFormatter.init()
        if dateFormat == nil {
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        }else{
            formatter.dateFormat = dateFormat
        }
        return formatter.string(from: date as Date)
    }
    
    
}
