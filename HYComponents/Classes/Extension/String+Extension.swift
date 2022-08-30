//
//  String+Extension.swift
//  HYComponents
//
//  Created by 🐲 on 2022/8/29.
//

import Foundation
import CommonCrypto

extension String {

    //根据日期样式  获取日期
    public func date(dateFormatter model:String = "yyyy-MM-dd") -> Date? {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = model
        let date = dateFormatter.date(from: self)
        return date
    }
    
    //获取年月日 的日期
    public func dateOfDateHourMinuteSecondStr() -> Date? {
       return date(dateFormatter: "yyyy-MM-dd HH:mm:ss")
    }
    
    //时间戳 转 日期
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

    
    //获取随机数
    public static let random_str_characters = "0123456789"
    public static func randomStr(len : Int) -> String{
        var ranStr = ""
        for _ in 0..<len {
            let index = Int(arc4random_uniform(UInt32(random_str_characters.count)))
            ranStr.append(random_str_characters[random_str_characters.index(random_str_characters.startIndex, offsetBy: index)])
        }
        return ranStr
    }
    
    //获取随机数
    public static func randomNumCustom(len:Int) -> String {
        
        var numStr = ""
        for _ in 0 ..< len {
            numStr = numStr + (arc4random() % 10).description
        }
        return numStr
    }
    
    /*
     MARK:  - String 长度
     */
    public var length:Int {
        get{return (self as NSString).length}
    }
    
    /*
     MARK: - String 转换 intValue = int32Value
     
     - returns: Int
     */
    public func int32Value() ->Int32{
        return NSString(string: self).intValue
    }
    
    /*
     MARK: - String 转换 integerValue
     
     - returns: Int
     */
    public func integerValue() ->Int{
        return NSString(string: self).integerValue
    }
    
    /*
     MARK: - String 转换 floatValue
     
     - returns: float
     */
    public func floatValue() ->Float{
        return NSString(string: self).floatValue
    }
    
    /*
     * MARK: - String 转换 CGFloatValue
     * - returns: CGFloat
     */
    public func CGFloatValue() ->CGFloat{
        return CGFloat(self.floatValue())
    }
    
    /*
     * MARK: - String 转换 doubleValue
     * - returns: double
     */
    public func doubleValue() ->Double{
        return NSString(string: self).doubleValue
    }
    /*
     * MARK: - String 转换 boolValue
     * - returns: double
     */
    public func boolValue() ->Bool{
        return NSString(string: self).boolValue
    }
    
    /*
     * MARK: - String 转换 DateValue
     * - returns: Date
     */
    public func dateValue() -> Date? {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: self)
        return date ?? Date()
    }
    
    /*
     * MARK: - String UTF8 编码
     * - return : String
     */
    public func UTF8() -> String {
        return String(describing: (self as NSString).utf8String)
    }
    /*
     * MARK: - String utf8encodedString 编码
     * - return : String
     */
    public func utf8encodedString() ->String {
        var arr = [UInt8]()
        arr += self.utf8
        return String(bytes: arr,encoding: String.Encoding.utf8)!
    }
    
    /*
     * MARK: - String UTF8 编码
     */
    public var utf8Encoded: Data {
        return self.data(using: .utf8)!
    }
    
    /*
     * MARK: - String Encoding 编码
     */
    
    public func stringWithEncoding() -> String {
        let value = self.addingPercentEncoding(withAllowedCharacters:NSCharacterSet(charactersIn:"`#%^{}/\"[]|//<> ").inverted)
        return value ?? ""
    }
    
    /*
     * MARK: - 截取字符串
     * - returns: String
     */
    public func substringWithRange(_ range:NSRange) ->String {
        
        return NSString(string: self).substring(with: range)
    }
    
    public func substringToIndex(_ subNum:NSInteger)  -> String {
        return NSString(string: self).substring(to: self.length - subNum)
    }
    
    
    /*
     * MARK: - 获得文件的后缀名（不带'.'）
     * - returns: String
     */
    public func pathExtension() ->String {
        
        return NSString(string: self).pathExtension
    }
    
    // MARK: 汉字 -> 拼音
    public func chineseToPinyin() -> String {
        
        let stringRef = NSMutableString(string: self) as CFMutableString
        // 转换为带音标的拼音
        CFStringTransform(stringRef,nil, kCFStringTransformToLatin, false)
        // 去掉音标
        CFStringTransform(stringRef, nil, kCFStringTransformStripCombiningMarks, false)
        let pinyin = stringRef as String
        
        return pinyin
    }
    //MARK:宽度
    public func getStringWidth(font:UIFont) -> CGSize {
        let maxSize:CGSize = CGSize(width: CGFloat(MAXFLOAT), height:20)
        let size = self.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : font], context: nil).size
        return size
    }
    // MARK: 判断是否含有中文
    public func isIncludeChineseIn() -> Bool {

//        let characts = NSArray()
//        for character in self {
//            characts.adding(character)
//        }
        
        for (_, value) in self.enumerated() {

            if ("\u{4E00}" <= value  && value <= "\u{9FA5}") {
                return true
            }
        }

        return false
    }
    
    // MARK: 获取第一个字符
    public func first() -> String {
        let index = self.index(self.startIndex, offsetBy: 1)
        return self.substring(to: index)
    }
    //MARK: - 从路径中获得完整的文件名（带后缀）
    
    /// 从路径中获得完整的文件名（带后缀）
    ///
    /// - Returns: String
    public func lastPathComponent() ->String {
        
        return NSString(string: self).lastPathComponent
    }
    
    //MARK:字符串日期 转 年月日
    mutating func toDateFormart(formart:String)  {
//        let inputFormatter = DateFormatter()
//        inputFormatter.dateFormat = "MM-dd-YYYY"
//
//        let outputFormatter = DateFormatter()
//        outputFormatter.dateFormat = "YYYY年MM月dd日"
//
//        let showDate = inputFormatter.date(from: self)
//        self = outputFormatter.string(from: showDate!)
//        return resultString
    }
    
    
    //MARK: - 获得文件名（不带后缀）
    
    /// 获得文件名（不带后缀）
    ///
    /// - Returns: String
    public func stringByDeletingPathExtension() ->String {
        return NSString(string: self).deletingPathExtension
    }
    
    //MARK: - 计算字符串大小
    
    /// 计算字符串大小
    ///
    /// - Parameter font: 字体大小
    /// - Returns: CGSize
    public func size(_ font:UIFont) ->CGSize {

       return size(font, constrainedToSize:CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
    }
    
    //MARK: - 计算字符串大小
    
    ///计算字符串大小
    ///
    /// - Parameters:
    ///   - font: 字体大小
    ///   - constrainedToSize: 当前控件大小
    /// - Returns: CGSize
    public func size(_ font:UIFont,constrainedToSize:CGSize) ->CGSize {
        
        let string:NSString = self as NSString
        
        return string.boundingRect(with: constrainedToSize, options: [.usesLineFragmentOrigin,.usesFontLeading], attributes: [kCTFontAttributeName as NSAttributedString.Key:font], context: nil).size
    }
    
    //MARK: - 是否有汉字
    
    /// 是否有汉字
    ///
    /// - Parameter string: 要检测字符串
    /// - Returns:Bool
//    static func ChineseIn(string: String) -> Bool {
//        for (_, value) in string.characters.enumerated() {
//            if ("\u{4E00}" <= value  && value <= "\u{9FA5}") {
//                return true
//            }
//        }
//        return false
//    }
    
    //MARK: - 是否包含英文
    
    ///是否包含英文
    ///
    /// - Returns: Bool
    public func EnglishIn()  -> Bool {
        for char in self.utf8  {
            if (char > 64 && char < 91) || (char > 96 && char < 123) {
                return true
            }
        }
        return false
    }
    
    //MARK: - 修改字符串指定颜色
    
    /// 修改字符串指定颜色
    ///
    /// - Parameters:
    ///   - changeStr: 将要替换颜色的字符串
    ///   - changeColor: 将要变为的颜色
    /// - Returns: NSMutableAttributedString
    public func ChangeColor(changeStr:String,changeColor:UIColor,font:UIFont)->NSMutableAttributedString{
        let attrstringH:NSMutableAttributedString = NSMutableAttributedString(string:self)
        let strH:NSString = NSString(string: self)
        let theRangeH = strH.range(of: changeStr)
        attrstringH.addAttribute(NSAttributedString.Key.foregroundColor, value: changeColor,range:theRangeH)
        //NSFontAttributeName
        attrstringH.addAttribute(NSAttributedString.Key.font , value:font,range:theRangeH)
        return attrstringH
    }
    
    /// 修改字符串指定颜色2
    ///
    /// - Parameters:
    ///   - changeStr: 将要替换颜色的字符串
    ///   - changeColor: 将要变为的颜色
    /// - Returns: NSMutableAttributedString
    public static func ChangeColor(_ contentStr:String,_ changeStr:String,_ changeColor:UIColor = UIColor.red,_ font:UIFont = UIFont.systemFont(ofSize: 14.0))->NSMutableAttributedString{
        
        let attrstringH:NSMutableAttributedString = NSMutableAttributedString(string:contentStr)
        let strH:NSString = contentStr as NSString
        
//        let theRangeH = strH.range(of: contentStr)
//        attrstringH.addAttribute(NSAttributedString.Key.foregroundColor, value: changeColor,range:theRangeH)
//        //NSFontAttributeName
//        attrstringH.addAttribute(NSAttributedString.Key.font , value:font,range:theRangeH)
        
        let theRangeH2 = strH.range(of: changeStr)
        attrstringH.addAttribute(NSAttributedString.Key.foregroundColor, value: changeColor,range:theRangeH2)
        //NSFontAttributeName
        attrstringH.addAttribute(NSAttributedString.Key.font , value:font,range:theRangeH2)
        
        
//        let paragraphStye = NSMutableParagraphStyle()
//        //调整行间距
//        paragraphStye.lineSpacing = 5
//        let rang = NSMakeRange(0, CFStringGetLength(strH as CFString))
//        attrstringH.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStye, range: rang)
        
        
        return attrstringH
    }
    
    //MARK: - 验证电话号码格式是否正确
    
    /// 验证电话号码格式是否正确
    ///
    /// - Returns: Bool
    public func checkTelNumber() -> Bool
    {
        
        let mobile = "^1[3|4|5|7|8][0-9]{9}$"
        let  CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
        let  CU = "^1(3[0-2]|5[256]|7[568]|8[56])\\d{8}$"
        let  CT = "^1((33|53|77|8[09])[0-9]|349)\\d{7}$"
        let  PHS = "(^$)|(^(0\\d{2})-(\\d{8})$)|(^(0\\d{3})-(\\d{7,8})$)|(^(0\\d{2})-(\\d{8})-(\\d+)$)|(^(0\\d{3})-(\\d{7,8})-(\\d+)$)"
        
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        let regextestPHS = NSPredicate(format: "SELF MATCHES %@" ,PHS)

        if ((regextestmobile.evaluate(with: self) == true)
            || (regextestcm.evaluate(with: self)  == true)
            || (regextestct.evaluate(with: self) == true)
            || (regextestcu.evaluate(with: self) == true)
            || (regextestPHS.evaluate(with: self) == true))
        {
            return true
        }
        return false
    }
    
    //MARK: - 身份证号的验证
    
    /// 身份证号的验证
    ///
    /// - Returns: Bool
    public func checkIDCard() -> Bool {
        let IDCardRegex = "^(\\d{14}|\\d{17})(\\d|[xX])$"
        let IDCardTest:NSPredicate = NSPredicate(format: "SELF MATCHES %@", IDCardRegex)
        return IDCardTest.evaluate(with: self)
    }
    
    //MAKR: - 字符串MD5加密
    
    /// 字符串MD5加密
    ///
    /// - Returns: String
    public func md5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        free(result)
        return String(format: hash as String)
    }
    
    //MARK: - 随机数生成器函数
    
    /// 随机数生成器函数
    ///
    /// - Returns: Int
    public func RandomNum()-> Int {
        return Int(arc4random()%99999999)+10000000
    }
    
    //MARK: - 价格删除划线
    
    /// 价格删除划线
    ///
    /// - Parameter text: 划线的金额
    /// - Returns: NSMutableAttributedString
    public func PriceLine(text:String) ->NSMutableAttributedString {
        
        let priceString = NSMutableAttributedString.init(string:text)
        priceString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSNumber.init(value: 1), range: NSRange(location:0, length: (text as NSString).length))
        return priceString
        
    }
    
    
    
    public var containsEmoji: Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F, // Emoticons
            0x1F300...0x1F5FF, // Misc Symbols and Pictographs
            0x1F680...0x1F6FF, // Transport and Map
            0x1F1E6...0x1F1FF, // Regional country flags
            0x2600...0x26FF,   // Misc symbols
            0x2700...0x27BF,   // Dingbats
            0xFE00...0xFE0F,   // Variation Selectors
            0x1F900...0x1F9FF,  // Supplemental Symbols and Pictographs
            127000...127600, // Various asian characters
            65024...65039, // Variation selector
            9100...9300, // Misc items
            8400...8447: // Combining Diacritical Marks for Symbols
                return true
            default:
                continue
            }
        }
        return false
    }
}

extension String{
    
    // JSONString转换为数组
    public static func getNSArrayFromJSONString(jsonString:String) ->NSArray{

        let jsonData:Data = jsonString.data(using: .utf8)!

        let list = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if list != nil {
            return list as! NSArray
        }
        return NSArray()
    }
    
    // JSONString转换为字典
    public static func getDictionaryFromJSONString(jsonString:String) ->NSDictionary{

        let jsonData:Data = jsonString.data(using: .utf8)!

        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()
    }
    
    // JSONString转换为字典
    public static func getArrayFromJSONString(jsonString:String) ->[[String:Any]]{
            
            let jsonData:Data = jsonString.data(using: .utf8)!
            
            let array = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [[String:Any]]
            if array != nil {
                return (array ?? [])!
            }
        return (array ?? [])!
            
    }
    
    // JSONString转换为字典
    public static func toJSONStringToArray(jsonString:String) ->[Any]{
            
            let jsonData:Data = jsonString.data(using: .utf8)!
            
            let array = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [Any]
            if array != nil {
                return (array ?? [])!
            }
            return []
            
    }
    
    
    //MARK: - 字符串转时间戳
    public func timeStrChangeTotimeInterval(_ dateFormat:String? = "yyyy-MM-dd HH:mm:ss") -> String {
        if self.isEmpty {
            return ""
        }
        let format = DateFormatter.init()
        format.dateStyle = .medium
        format.timeStyle = .short
        if dateFormat == nil {
            format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        }else{
            format.dateFormat = dateFormat
        }
        let date = format.date(from: self)
        return String(date!.timeIntervalSince1970)
    }
}


extension NSAttributedString{
    
    //MARK: - 计算多态字符串的size
    
    /// 计算多态字符串的size
    ///
    /// - Parameter constrainedToSize: 大小
    /// - Returns: CGSize
    public func size(_ constrainedToSize:CGSize?) ->CGSize{
        
        var tempConstrainedToSize = constrainedToSize
        
        if constrainedToSize == nil {tempConstrainedToSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)}
        
        return self.boundingRect(with: tempConstrainedToSize!, options: [NSStringDrawingOptions.usesLineFragmentOrigin,NSStringDrawingOptions.usesFontLeading], context: nil).size
    }
}

extension String{
    
    
    public func sha1() -> String {
        let data = self.data(using: String.Encoding.utf8)!
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
        CC_SHA1((data as NSData).bytes, CC_LONG(data.count), &digest)
        let output = NSMutableString(capacity: Int(CC_SHA1_DIGEST_LENGTH))
        for byte in digest {
            output.appendFormat("%02x", byte)
        }
        return output as String
    }
  
    public func encrypt(key:String,encryptData:String){

        let inputData : Data = encryptData.data(using: String.Encoding.utf8)!
     
        let keyData: Data = key.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        let keyBytes = UnsafeMutableRawPointer(mutating: (keyData as NSData).bytes)
        let keyLength = size_t(kCCKeySize3DES)
     
        let dataLength = Int(inputData.count)
        let dataBytes = UnsafeRawPointer((inputData as NSData).bytes)
        let bufferData = NSMutableData(length: Int(dataLength) + kCCBlockSize3DES)!
        let bufferPointer = UnsafeMutableRawPointer(bufferData.mutableBytes)
        let bufferLength = size_t(bufferData.length)
        var bytesDecrypted = Int(0)
            
        let cryptStatus = CCCrypt(
            UInt32(kCCEncrypt),
            UInt32(kCCAlgorithm3DES),
            UInt32(kCCOptionECBMode + kCCOptionPKCS7Padding),
            keyBytes,
            keyLength,
            nil,
            dataBytes,
            dataLength,
            bufferPointer,
            bufferLength,
            &bytesDecrypted)
     
            if Int32(cryptStatus) == Int32(kCCSuccess) {
                bufferData.length = bytesDecrypted
                let value = String(data: bufferData as Data, encoding: String.Encoding.utf8)
                print(value)
            } else {
                print("加密过程出错: \(cryptStatus)")
            }
        }


}

extension String{
    
    public func removeHTML()->String{
        let str = self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil).replacingOccurrences(of: "&nbsp", with: "")
        return str
    }
    public func deleteHTMLTag(tag:String) -> String {
        return self.replacingOccurrences(of: "(?i)</?\(tag)\\b[^<]*>", with: "", options: .regularExpression, range: nil)
    }
    
    public func deleteHTMLTags(tags:[String]) -> String {
        var mutableString = self
        for tag in tags {
            mutableString = mutableString.deleteHTMLTag(tag: tag)
        }
        return mutableString
    }
    
    ///去掉字符串标签
    public mutating func filterHTML() -> String?{
        let scanner = Scanner(string: self)
        var text: NSString?
        while !scanner.isAtEnd {
            scanner.scanUpTo("<", into: nil)
            scanner.scanUpTo(">", into: &text)
            self = self.replacingOccurrences(of: "\(text == nil ? "" : text!)>", with: "")
        }
        return self
    }
    
    
    public func  filterImageUrlFromHTML() -> [String]?
    {
        let regex = "(http[^\\s]+(jpg|jpeg|png|tiff)\\b)"
        do {
            let regularExpression = try NSRegularExpression(pattern: regex, options: [])
              let string = self as NSString
            let range = NSMakeRange(0, self.count)
            let results = regularExpression.matches(in: self, options: [], range: range)
          
            return results.map { string.substring(with: $0.range)}
        } catch {
            return nil
        }
     
    }
}

extension String {
    public func isPurnFloat() -> Bool {
        
        let scan: Scanner = Scanner(string: self)
        
        var val:Float = 0
        
        return scan.scanFloat(&val) && scan.isAtEnd
        
    }
    
    public func isPurnInt() -> Bool {
        
        let scan: Scanner = Scanner(string: self)
        
        var val:Int = 0
        
        return scan.scanInt(&val) && scan.isAtEnd
        
    }
    
   
}

extension String{
    //1. 验证是否是手机号码格式
    public func validFormatMobile() -> Bool {
        let regex = "^[1][0-9]{10}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    return predicate.evaluate(with: self)
    }
}
