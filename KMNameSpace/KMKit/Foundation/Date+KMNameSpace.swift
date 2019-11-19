//
//  Date+KMNameSpace.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/18.
//  Copyright © 2019 KM. All rights reserved.
//

import Foundation


extension Date: KMKitNamespaceWrappable {}

extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType == Date {
    
    
    
    static var _formatter = DateFormatter()
    
    func string(withFormat format: String = "dd/MM/yyyy HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: kmWrappedValue)
    }
    
    static func formateDate(date: Date, format: String) -> String {
        _formatter.dateFormat = format
        return _formatter.string(from: date)
    }

    /// 是否是今年
    /// - Parameter date: 时间
    static func isThisYear(date:Date) -> Bool {
        let calendar = Calendar.current
        let nowCmps = calendar.component(Calendar.Component.year, from: Date())
        let selfCmps = calendar.component(.year, from: date)
        return nowCmps == selfCmps
    }
    
    /// 当前日期
    /// - Returns: yyyy-MM-dd日期格式
    static func currenDate() -> String {
        let currenDateStr = Date.init().km.string(withFormat: "yyyy-MM-dd")
        return currenDateStr
    }
    
    static func formatDateWithJavaTime(time:Double, format: String = "yyyy.MM.dd HH:mm") -> String{
        var newTime = time
        if newTime > 9999999999{
            newTime = newTime / 1000
        }
        let date = Date.init(timeIntervalSince1970: newTime)
        return Date.KM.formateDate(date: date, format: format)
    }
    
    static func translateDateWithJavaTime(time: Double) -> String {
        var newTime = time
        if newTime > 9999999999{
            newTime = newTime / 1000
        }
        let confromTimesp = Date.init(timeIntervalSince1970: newTime)
        return self.compareCurrentTime(timeDate: confromTimesp, justDate: false)
    }
    
    static func compareCurrentTime(timeDate:Date, justDate:Bool) -> String {
        let dateFormatter = DateFormatter()
        let currentDate = Date()
        let timeInterval = currentDate.timeIntervalSince(timeDate)
        var temp: Int = 0
        var result = ""
        
        if justDate{
            dateFormatter.dateFormat = "yyyy-MM-dd"
            result = dateFormatter.string(from: timeDate)
            return result
        }
        
        if (timeInterval/60 < 1) {
            result = "刚刚"
        }
        else if((timeInterval / 60) < 60){
            temp = Int(timeInterval / 60)
            result = "\(temp)分钟前"
        }
        else if((timeInterval / 3600) < 24){
            temp = Int(timeInterval/3600)
            result = "\(temp)小时前"
        }
        else if((timeInterval / 86400) < 10){
            temp = Int(timeInterval / 86400)
            if (temp == 1) {
                result = "昨天";
            }else if(temp == 2){
                result = "前天";
            }else{
                result = "\(temp)天前"
            }
        }
        else { //显示年月日
            dateFormatter.dateFormat = "yyyy/MM/dd"
            result = dateFormatter.string(from: timeDate)
        }
        return result;
    }
    
    static func translateDate(withInterval: TimeInterval, justDate: Bool) -> String{
        let date = Date.init(timeIntervalSince1970: withInterval)
        return translateDate(withTimeDate: date, justDate: justDate)
    }
    
    static func translateDate(withTimeDate: Date, justDate: Bool) -> String{
        let dateFormatter = DateFormatter.init()
        let currentDate = Date.init()
        let timeInterval  = currentDate.timeIntervalSince(withTimeDate)
        
        var temp: Double = 0
        var result = ""
        
        if justDate {
            dateFormatter.dateFormat = "yyyy.MM.dd"
            result = dateFormatter.string(from: withTimeDate)
            return result
        }
        
        if timeInterval / 60.0 < 1.0{
            return "刚刚"
        }else if timeInterval / 60.0 < 60.0{
            temp = timeInterval / 60.0
            return "\(Int(temp))分钟前"
        }else if timeInterval / 3600.0 < 24.0{
            temp = timeInterval / 3600.0
            return "\(Int(temp))小时前"
        }else if(timeInterval / 86400.0 < 10.0){
            temp = floor(timeInterval / 86400)
            if temp == 1{
                return "昨天"
            }else if temp == 2{
                return "前天"
            }else{
                return "\(Int(temp))天前"
            }
        }else{
            dateFormatter.dateFormat = "yyyy.MM.dd"
            result = dateFormatter.string(from: withTimeDate)
        }
        return result
    }
    
    

    
    /// 转换日期 大于1天显示天数  大于一小时显示小时  小于一小时显示分钟
    static func translateDateToDesString(time: TimeInterval) -> String {
        return ""
        
//        var newTime = time
//        if newTime > 9999999999{
//            newTime = newTime / 1000
//        }
//
//        let time = newTime - Date().timeIntervalSince1970
//        //一天多少秒
//        let oneDaySeconds:TimeInterval = 60 * 60 * 24
//        let days = Int(time / oneDaySeconds)
//        let hours = Int((time - TimeInterval(days) * oneDaySeconds) / 60 / 60)
//        let mins = Int(time - TimeInterval(days) * oneDaySeconds - TimeInterval(hours) * 60 * 60) / 60
//
//        if days.abs >= 1 {
//            return "\(days.abs)\(LocalizedManager.Date.day.localizedString)"
//        }else if hours.abs >= 1{
//            return "\(hours.abs)\(LocalizedManager.Date.hour.localizedString)"
//        }else {
//            return "\(mins.abs)\(LocalizedManager.Date.min.localizedString)"
//        }
    }
    
    /// 转换日期 显示具体多少天多少小时
    static func translateDateToDetailString(time: TimeInterval) -> String {
        
        return ""
//        var newTime = time
//        if newTime > 9999999999{
//            newTime = newTime / 1000
//        }
//
//        let time = abs(newTime - Date().timeIntervalSince1970)
//        //一天多少秒
//        let oneDaySeconds:TimeInterval = 60 * 60 * 24
//        let days = Int(time / oneDaySeconds)
//        let hours = Int((time - TimeInterval(days) * oneDaySeconds) / 60 / 60)
//        let mins = Int((time - TimeInterval(days) * oneDaySeconds - TimeInterval(hours) * 60 * 60) / 60)
//
//        if abs(days) >= 1 {
//            return "\(abs(days))\(LocalizedManager.Date.day.localizedString)\(abs(hours))\(LocalizedManager.Date.hour.localizedString)"
//        }else if abs(hours) >= 1{
//            return "\(hours.abs)\(LocalizedManager.Date.hour.localizedString)\(mins.abs)\(LocalizedManager.Date.min.localizedString)"
//        }else {
//            return "\(mins.abs)\(LocalizedManager.Date.min.localizedString)"
//        }
    }
    
    
    static func indexOfWeekday(_ date: Date) -> Int {
        let array = [2, 3, 4, 5, 6, 7, 1]
        let weekday = Calendar.current.component(.weekday, from: date)
        return array.firstIndex(of: weekday) ?? 0
    }
    
}




extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType == Date {
    
    
    
    // MARK: - Component Properties

    /// Year component
    var year: Int {
        Calendar.current.dateComponents([.year], from: kmWrappedValue).year ?? -1
    }
    
    /// Month component (1~12)
    var month: Int {
        Calendar.current.dateComponents([.month], from: kmWrappedValue).month ?? -1
    }
    
    /// Day component (1~31)
    var day: Int {
        Calendar.current.dateComponents([.day], from: kmWrappedValue).day ?? -1
    }
    
    /// Hour component (0~23)
    var hour: Int {
        Calendar.current.dateComponents([.hour], from: kmWrappedValue).hour ?? -1
    }
    
    /// Minute component (0~59)
    var minute: Int {
        Calendar.current.dateComponents([.minute], from: kmWrappedValue).minute ?? -1
    }
    
    /// Second component (0~59)
    var second: Int {
        Calendar.current.dateComponents([.second], from: kmWrappedValue).second ?? -1
    }
    
    /// Nanosecond component
    var nanosecond: Int {
        Calendar.current.dateComponents([.nanosecond], from: kmWrappedValue).second ?? -1
    }
    
    /// Weekday component (1~7, first day is kmWrappedValued on user setting)
    var weekday: Int {
        Calendar.current.dateComponents([.weekday], from: kmWrappedValue).weekday ?? -1
    }
     
    /// WeekdayOrdinal component
    var weekdayOrdinal: Int {
        Calendar.current.dateComponents([.weekdayOrdinal], from: kmWrappedValue).weekdayOrdinal ?? -1
    }
    
    /// WeekOfMonth component (1~5)
    var weekOfMonth: Int {
        Calendar.current.dateComponents([.weekOfMonth], from: kmWrappedValue).weekOfMonth ?? -1
    }
     
    /// WeekOfYear component (1~53)
    var weekOfYear: Int {
        Calendar.current.dateComponents([.weekOfYear], from: kmWrappedValue).weekOfYear ?? -1
    }
    
    /// YearForWeekOfYear component
    var yearForWeekOfYear: Int {
        Calendar.current.dateComponents([.yearForWeekOfYear], from: kmWrappedValue).yearForWeekOfYear ?? -1
    }
   
    /// Quarter component
    var quarter: Int {
        Calendar.current.dateComponents([.quarter], from: kmWrappedValue).quarter ?? -1
    }
     
    /// whether the month is leap month
    var isLeapMonth: Bool {
        Calendar.current.dateComponents([.quarter], from: kmWrappedValue).isLeapMonth ?? false
    }
    
    /// whether the year is leap year
    var isLeapYear: Bool {
        let year = self.year
        return ((year % 400 == 0) || ((year % 100 != 0) && (year % 4 == 0)))
    }
    
    /// whether date is today (kmWrappedValued on current locale)
    var isToday: Bool {
        if abs(kmWrappedValue.timeIntervalSinceNow) >= 60 * 60 * 24 {
            return false
        }
        return Date().km.day == kmWrappedValue.km.day
    }
    
    /// whether date is yesterday (kmWrappedValued on current locale)
    var isYesterday: Bool {
        
        guard let added = kmWrappedValue.km.addDays(1) else {
            return false
        }
        
        return added.km.isToday
    }
    
    
    
    // MARK: - Date modify

    
    /// N年后的这个时候
    /// - Parameter years: 年数，可以为负数
    func addYears(_ years: Int) -> Date? {
        let calendar = Calendar.current
        var components = DateComponents()
        components.year = years
        return calendar.date(byAdding: components, to: kmWrappedValue, wrappingComponents: false)
    }
    
    
    /// <#Description#>
    /// - Parameter months: <#months description#>
    func addMonths(_ months: Int) -> Date? {
        let calendar = Calendar.current
        var components = DateComponents()
        components.month = months
        return calendar.date(byAdding: components, to: kmWrappedValue, wrappingComponents: false)
    }

    
    /// <#Description#>
    /// - Parameter weeks: <#weeks description#>
    func addWeeks(_ weeks: Int) -> Date? {
        let calendar = Calendar.current
        var components = DateComponents()
        components.weekOfYear = weeks
        return calendar.date(byAdding: components, to: kmWrappedValue, wrappingComponents: false)
    }

    
    /// <#Description#>
    /// - Parameter days: <#days description#>
    func addDays(_ days: Int) -> Date? {
        let aTimeInterval = kmWrappedValue.timeIntervalSinceReferenceDate + 86400 * TimeInterval(days)
        let newDate = Date(timeIntervalSinceReferenceDate: aTimeInterval)
        return newDate
    }

    
    /// <#Description#>
    /// - Parameter hours: <#hours description#>
    func addHours(_ hours: Int) -> Date? {
        let aTimeInterval = kmWrappedValue.timeIntervalSinceReferenceDate + 3600 * TimeInterval(hours)
        let newDate = Date(timeIntervalSinceReferenceDate: aTimeInterval)
        return newDate
    }
    
    
    /// <#Description#>
    /// - Parameter minutes: <#minutes description#>
    func addMinutes(_ minutes: Int) -> Date? {
        let aTimeInterval = kmWrappedValue.timeIntervalSinceReferenceDate + 60 * TimeInterval(minutes)
        let newDate = Date(timeIntervalSinceReferenceDate: aTimeInterval)
        return newDate
    }
    
    
    /// <#Description#>
    /// - Parameter seconds: <#seconds description#>
    func addSeconds(_ seconds: Int) -> Date? {
        let aTimeInterval = kmWrappedValue.timeIntervalSinceReferenceDate + TimeInterval(seconds)
        let newDate = Date(timeIntervalSinceReferenceDate: aTimeInterval)
        return newDate
    }

    
    
    //MARK: -  Date Format

    
    /// 格式化输出
    /// - Parameter format: 输出格式
    /// - Parameter timeZone: 时区
    /// - Parameter locale: 地区
    func  stringWithFormat(_ format: String = "yyyy-MM-dd HH:mm:ss", timeZone: TimeZone? = .current, locale: Locale? = .current) -> String? {
        
        let formatter = DateFormatter()
        formatter.dateFormat = format

        if let zone = timeZone {
            formatter.timeZone = zone
        }
        
        if let l = locale {
            formatter.locale = l
        }
        
        return formatter.string(from: kmWrappedValue)
        
    }
        
    /// ISO标准格式输出
    func stringWithISOFormat() -> String? {
        let formatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter.string(from: kmWrappedValue)
    }

    
    /// <#Description#>
    /// - Parameter dateString: <#dateString description#>
    /// - Parameter format: <#format description#>
    /// - Parameter timeZone: <#timeZone description#>
    /// - Parameter locale: <#locale description#>
    func dateWithString(_ dateString: String, format: String = "yyyy-MM-dd HH:mm:ss", timeZone: TimeZone? = .current, locale: Locale? = .current) -> Date? {
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        if let z = timeZone {
            formatter.timeZone = z
        }

        if let l = locale {
            formatter.locale = l
        }

        return formatter.date(from: dateString)

    }
    
    
    /// <#Description#>
    /// - Parameter dateString: <#dateString description#>
    func dateWithISOFormatString(_ dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter.date(from: dateString)
    }

}
