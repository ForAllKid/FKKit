//
//  String+KMNameSpace.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/18.
//  Copyright © 2019 KM. All rights reserved.
//

import Foundation
import UIKit
import CommonCrypto

extension String: KMKitCompatible {}

public extension KMKitWrapper where KMKitWrapperType == String {
    
    static func judgeAddZeroBeforeTheNum(targetID : Double) -> String {
        let str = String.init(format: "%.f", targetID)
        if str.count >= 9{
            return self.hanleNums(number: str)
        }else{
            let strr =  String.init(format: "%09.f", targetID)
            return self.hanleNums(number: strr)
        }
    }
    
    static func hanleNums(number: String) -> String {
        let str = number

        var newString = str.km.slice(from: number.count % 3, to: number.count - number.count % 3)
        var strs = number
        newString = strs.km.slice(from: 0, to: strs.count % 3)

        for i in stride(from: 0, to:newString.count , by: 3){
            let sss = str
            sss.km.slice(from: i, to: i + 3)
            strs += "/\(sss)"
        }
        let strstemp = strs
        if strstemp.km.slice(from: 0, to: 1)  == "/"{
            strs.km.slice(from: 1, to: strs.count)
        }
        return strs

    }
    
    static func toArray(JSONString: String) -> Array<Any>? {
        
        let data = JSONString.data(using:.utf8)!

        let jsonObject = try? JSONSerialization.jsonObject(
                with: data,
                options: .allowFragments
            ) as? Array<Any>

        return jsonObject
    }
    
    
    static func transform(chinese: String) -> String{
        
        let mutableString = NSMutableString(string: chinese)
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
        let string = String(mutableString)
        return string
        
        //        let pinyin = chinese
        //        CFStringTransform((pinyin as! CFMutableString), nil, kCFStringTransformMandarinLatin, false)
        //        CFStringTransform((pinyin as! CFMutableString), nil, kCFStringTransformStripCombiningMarks, false);
        //        return pinyin;
    }
    
    static func string2percentEncode(str: String) -> String {
        return str.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    
    static func decodedString(str : String) -> String {
        return str.removingPercentEncoding ?? str
    }
    
    
    static func sizeForString(string: String, font: UIFont, constrainedToSize: CGSize) -> CGSize{
        let nsstr = NSString.init(string: string)
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineBreakMode = .byWordWrapping
        let attrs = [NSAttributedString.Key.font: font, NSAttributedString.Key.paragraphStyle: paragraphStyle]
        let boundingRect = nsstr.boundingRect(with: constrainedToSize, options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
        return CGSize.init(width: ceil(Double(boundingRect.size.width)), height: ceil(Double(boundingRect.size.height)))
    }
    
    static func encodeString(sourceString: String) -> String {
        
        let encodedString =  CFURLCreateStringByAddingPercentEscapes(
            kCFAllocatorDefault,
            sourceString as CFString,
            "!$&'()*+,-./:;=?@_~%#[]" as CFString,
            nil,
            CFStringBuiltInEncodings.UTF8.rawValue
        )
        
        return encodedString! as String
    }
    
    static func returnCommaFormater(target: Int) -> String{
        let format = NumberFormatter()
        format.numberStyle = .decimal
        let string = format.string(from: NSNumber(value: target))
        return string ?? "0"
    }
    
    static func returnFormaterNumber(target: Double) -> String {
        
        if target > 999999 {
            return "999,999+"
        }
        
        let formatter = NumberFormatter()
        formatter.positiveFormat = "###,###"
        let string = formatter.string(from: NSNumber.init(value: target))
        return string ?? ""
 
    }
    
    static func convertToJSONData(infoDict:Dictionary<String,Any>) -> String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: infoDict, options: .prettyPrinted)
            var jsonString = String.init(data: jsonData, encoding: .utf8)
            jsonString = jsonString?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            jsonString = jsonString?.replacingOccurrences(of: "\n", with: "")
            
            return jsonString
        }catch{
            
        }
        return nil
    }
    
    static func setLineSpace(oriString:String?,lineSpace: CGFloat) -> NSAttributedString? {
        if let oriString = oriString{
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpace
            let newatt = NSAttributedString.init(string: oriString, attributes: [NSAttributedString.Key.paragraphStyle  : paragraphStyle])
            return newatt
        }
        return nil
    }
    
    static func getHeightOfString(in string: NSAttributedString, font: UIFont?, lableWidth: CGFloat, maxLines: Int, lineCount: inout Int) -> CGFloat {
        
        //改进
        if string.length <= 0 {
            lineCount = 0
            return 0
        }
        
        let attStr = string
        
        let frameSetter = CTFramesetterCreateWithAttributedString(attStr)
        
        let height: CGFloat = 10000
        let path = UIBezierPath(roundedRect: .init(x: 0, y: 0, width: lableWidth, height: height), cornerRadius: 0.0)
        
        
        let frame = CTFramesetterCreateFrame(frameSetter, .init(location: 0, length: 0), path.cgPath, nil)
        
        let lines = CTFrameGetLines(frame)
        
        //逐行lineHeight累加
        var heightValue: CGFloat = 0;
        let count = min(maxLines, CFArrayGetCount(lines))
        
        if (count <= 0) {
            return 0
        }
        
        
        
        //获取所有行origin坐标
        
        let lineOrigins = UnsafeMutablePointer<CGPoint>.allocate(capacity: CFArrayGetCount(lines))
        
        CTFrameGetLineOrigins(frame, .init(location: 0, length: 0), lineOrigins)
        
        //最后一行原点y坐标加最后一行下行行高跟行距
        let line_y = CGFloat(lineOrigins[count - 1].y)//最后一行line的原点y坐标
        
        var lastAscent: CGFloat = 0 //上行行高
        var lastDescent: CGFloat = 0 //下行行高
        
        var lastLeading: CGFloat = 0 //行距
        let lastLine = CFArrayGetValueAtIndex(lines, count - 1)
        
        let ctLine = unsafeBitCast(lastLine, to: CTLine.self)
        CTLineGetTypographicBounds(ctLine, &lastAscent, &lastDescent, &lastLeading)
        //height - line_y为除去最后一行的字符原点以下的高度，descent + leading为最后一行不包括上行行高的字符高度
        heightValue = height - line_y + (abs(lastDescent) + lastLeading)
        heightValue = ceil(heightValue)
        
        lineCount = CFArrayGetCount(lines);
        
        return heightValue;
    }
    
    static func unmaskEmoji(_ string : String) -> String {
        //四位处理
        var newString = string
        do{
            let fourRegularExpression = try NSRegularExpression.init(pattern: "\\[emoji:\\w{4}\\]", options: NSRegularExpression.Options.caseInsensitive)
            
            let fourA = fourRegularExpression.matches(in: string, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSRange.init(location: 0, length: string.count))
            
            for i in stride(from: fourA.count - 1, to: 0, by: -1){
                let result = fourA[i]
                let arange : Range! = Range.init(result.range, in: newString)
                newString = newString.replacingCharacters(in: arange, with: "")
            }
            
        }catch{}
        
        //八位处理
        do{
            let regularExpression = try NSRegularExpression.init(pattern: "\\[emoji:\\w{8}\\]", options: NSRegularExpression.Options.caseInsensitive)
            
            let a = regularExpression.matches(in: string, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSRange.init(location: 0, length: newString.count))
            
            for i in stride(from: a.count - 1, to: 0, by: -1){
                let result = a[i]
                
                if let range = Range.init(NSMakeRange(result.range.location + 7, result.range.length - 8), in: newString){
                    var test = String(newString[range.lowerBound...range.upperBound])
                    test = self.convertString2Unicode(test)
                    
                    let arange : Range! = Range.init(result.range, in: newString)
                    newString = newString.replacingCharacters(in: arange, with: test)
                    
                }
            }
            
        }catch{}
        
        return newString
    }
    
    static func convertString2Unicode(_ input : String) -> String{
        if input.count == 8 {
            let start = input.startIndex  // 开始下标
            let end = input.index(input.startIndex, offsetBy: 4) // 结束下标
            let oneString = String(input[start ... end])
            let one = strtoul(NSString.init(string: oneString).utf8String,nil,16)
            let towEnd = input.index(end, offsetBy: 4)
            let twoString = String(input[end ... towEnd])
            let two = strtoul(NSString.init(string: twoString).utf8String,nil,16)
            return String.init(format: "%C%C", one,two)
        }else{
            return input
        }
    }
    
    static func judgeStrIsOrNotPureNumber(target : String) -> Bool {
        let newTarget = target.trimmingCharacters(in: CharacterSet.decimalDigits)
        if newTarget.count > 0{
            return false
        }
        return true
        
    }
    
    /// 内存大小字符串 转 字节
    static func memoryStringToByte(string:String) -> Double {
        return string.km.toBytes
    }
    

    static func byteToString(byteNum: Int64) -> String{
        if byteNum == 0 {
            return "0M"
        }
        let string = ByteCountFormatter.string(fromByteCount: byteNum, countStyle: .binary)
        return string
    }
    
    static func rounding(with value:CGFloat, afterPoint: Int16) -> CGFloat {
        let handler = NSDecimalNumberHandler.init(roundingMode: NSDecimalNumber.RoundingMode.bankers, scale: afterPoint, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: true)
        let ounces = NSDecimalNumber.init(value: Float(value))
        let value = ounces.rounding(accordingToBehavior: handler).floatValue
        return CGFloat(value)
    }
    
    
    
    func sizeWithFont(_ font: UIFont, constrainedToSize: CGSize, lineSpace: CGFloat = 0.0) -> CGSize {
        
        let nsstr = kmWrappedValue as NSString
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        paragraphStyle.lineSpacing = lineSpace
        
        let attrs: [NSAttributedString.Key: Any] = [
            .font: font,
            .paragraphStyle: paragraphStyle
        ]
        let boundingRect = nsstr.boundingRect(
            with: constrainedToSize,
            options: .usesLineFragmentOrigin,
            attributes: attrs,
            context: nil
        ).integral
        
        return boundingRect.size
    }
    
    func subString(range: NSRange) -> String? {
        
        guard range.location + range.length <= kmWrappedValue.count else {
            return nil
        }
        
        let start = kmWrappedValue.index(kmWrappedValue.startIndex, offsetBy: range.location)  // 开始下标
        let end = kmWrappedValue.index(start, offsetBy: range.length) // 结束下标
        let subString = kmWrappedValue[start ..< end]
        return String(subString)

    }
}


public extension KMKitWrapper where KMKitWrapperType == String {
    
    @discardableResult
    func slice(from start: Int, to end: Int) -> String {
        
        guard end >= start else { return kmWrappedValue }

        let NSString = kmWrappedValue as NSString

        let sub = NSString.substring(with: .init(location: start, length: end - start))

        return sub
    }
    
}





public extension KMKitWrapper where KMKitWrapperType == String {
    
    /// 内存大小字符串 转 字节
    var toBytes: Double {
        
        if kmWrappedValue.contains("GB"){
            let count = Double(kmWrappedValue.replacingOccurrences(of: "GB", with: "")) ?? 0
            return count * 1024 * 1024 * 1024
        }
        
        if kmWrappedValue.contains("MB") {
            let count = Double(kmWrappedValue.replacingOccurrences(of: "MB", with: "")) ?? 0
            return count * 1024 * 1024
        }
        
        if kmWrappedValue.contains("KB"){
            let count = Double(kmWrappedValue.replacingOccurrences(of: "KB", with: "")) ?? 0
            return count * 1024
        }
        
        return 0
    }
    
    var MD5: String {
        
        let cStrl = kmWrappedValue.cString(using: .utf8)
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        CC_MD5(cStrl, CC_LONG(strlen(cStrl!)), buffer)
        
        var md5String = ""
        for idx in 0...15 {
            let obcStrl = String(format: "%02x", buffer[idx]);
            md5String.append(obcStrl);
        }
        
        free(buffer)
        return md5String
        
    }
    
    
    
}

