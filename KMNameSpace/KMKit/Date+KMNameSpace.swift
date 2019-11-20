//
//  Date+KMNameSpace.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/18.
//  Copyright © 2019 KM. All rights reserved.
//

import Foundation


extension Date: KMKitNamespaceWrappable {}

public extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType == Date {
    
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



// MARK: - Component Properties


public extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType == Date {
        
    /// Year component
    var year: Int {
        Calendar.current.component(.year, from: kmWrappedValue)
    }
    
    /// Month component (1~12)
    var month: Int {
        Calendar.current.component(.month, from: kmWrappedValue)
    }
    
    /// Day component (1~31)
    var day: Int {
        Calendar.current.component(.day, from: kmWrappedValue)
    }
    
    /// Hour component (0~23)
    var hour: Int {
        Calendar.current.component(.hour, from: kmWrappedValue)
    }
    
    /// Minute component (0~59)
    var minute: Int {
        Calendar.current.component(.minute, from: kmWrappedValue)
    }
    
    /// Second component (0~59)
    var second: Int {
        Calendar.current.component(.second, from: kmWrappedValue)
    }
    
    /// Nanosecond component
    var nanosecond: Int {
        Calendar.current.component(.nanosecond, from: kmWrappedValue)
    }
    
    /// Weekday component (1~7, first day is kmWrappedValued on user setting)
    var weekday: Int {
        Calendar.current.component(.weekday, from: kmWrappedValue)
    }
     
    /// WeekdayOrdinal component
    var weekdayOrdinal: Int {
        Calendar.current.component(.weekdayOrdinal, from: kmWrappedValue)
    }
    
    /// WeekOfMonth component (1~5)
    var weekOfMonth: Int {
        Calendar.current.component(.weekOfMonth, from: kmWrappedValue)
    }
     
    /// WeekOfYear component (1~53)
    var weekOfYear: Int {
        Calendar.current.component(.weekOfYear, from: kmWrappedValue)
    }
    
    /// YearForWeekOfYear component
    var yearForWeekOfYear: Int {
        Calendar.current.component(.yearForWeekOfYear, from: kmWrappedValue)
    }
   
    /// Quarter component
    var quarter: Int {
        Calendar.current.component(.quarter, from: kmWrappedValue)
    }
    
}

// MARK: - 时间段判断 所有的判断都是基于当前的日历

public extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType == Date {
     
    
    /// 是否是闰月
    var isLeapMonth: Bool {
        Calendar.current.dateComponents([.quarter], from: kmWrappedValue).isLeapMonth ?? false
    }
    
    /// 是否是闰年（400的倍数或者 是4的倍数并且不能是100的倍数）
    var isLeapYear: Bool {
        let year = self.year
        return ((year % 400 == 0) || ((year % 100 != 0) && (year % 4 == 0)))
    }
        
    /// 是否是今天（当前系统日历）
    var isToday: Bool {
        return Calendar.current.isDateInToday(kmWrappedValue)
    }
        
    /// 是否是昨天(当前系统日历)
    var isYesterday: Bool {
        return Calendar.current.isDateInYesterday(kmWrappedValue)
    }
    
    /// 是否是明天（当前系统日历）
    var isTomorrow: Bool {
        return Calendar.current.isDateInTomorrow(kmWrappedValue)
    }
    
    /// 是否在当前周内
    var isCurrentWeek: Bool {
        return Calendar.current.isDate(kmWrappedValue, equalTo: Date(), toGranularity: .weekOfYear)
    }
    
    /// 是否在当前月内
    var isInCurrentMonth: Bool {
        return Calendar.current.isDate(kmWrappedValue, equalTo: Date(), toGranularity: .month)
    }
    
    /// 是否在当前年内
    var isInCurrentYear: Bool {
        return Calendar.current.isDate(kmWrappedValue, equalTo: Date(), toGranularity: .year)
    }
    
    /// 是否是过去（基于当前时间）
    var isPast: Bool {
        return kmWrappedValue < Date()
    }
    
    /// 是否是将来（基于当前时间）
    var isFuture: Bool {
        return kmWrappedValue > Date()
    }
    
}



// MARK: - Date modify

public extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType == Date {

    
    /// 返回一个新的“日期”，该日期表示通过在给定日期上添加一定数量的值而计算出的日期。
    ///
    /// - Parameter component: .year, .month ....
    /// - Parameter value: 值，可为负数
    func adding(_ component: Calendar.Component, value: Int) -> Date? {
        return Calendar.current.date(byAdding: component, value: value, to: kmWrappedValue)
    }

    
    /// 递增年
    /// - Parameter years: 年数，可以为负数
    func addYears(_ years: Int) -> Date? {
        return adding(.year, value: years)
    }
    
    
    /// 递增月
    /// - Parameter months: 月，可为负数
    func addMonths(_ months: Int) -> Date? {
        return adding(.month, value: months)
    }

    
    /// 递增周
    /// - Parameter weeks: 周，可为负数
    func addWeeks(_ weeks: Int) -> Date? {
        return adding(.weekOfYear, value: weeks)
    }

    
    /// 递增天
    /// - Parameter days: 天，可为负数
    func addDays(_ days: Int) -> Date? {
        return adding(.day, value: days)
    }

    
    /// 递增小时
    /// - Parameter hours: 小时，可为负数
    func addHours(_ hours: Int) -> Date? {
        return adding(.hour, value: hours)
    }
    
    
    /// 递增分钟
    /// - Parameter minutes: 分钟，可为负数
    func addMinutes(_ minutes: Int) -> Date? {
        return adding(.minute, value: minutes)
    }
    
    
    /// 递增秒
    /// - Parameter seconds: 秒，可为负数
    func addSeconds(_ seconds: Int) -> Date? {
        return adding(.second, value: seconds)
    }

    
}
 
//MARK: -  格式化

public extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType == Date {

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

    
    /// 根据指定的格式将一个时间字符串转换为时间，转换过程如果为`nil`表示转换失败
    /// - Parameter dateString: 时间字符串
    /// - Parameter format: 格式
    /// - Parameter timeZone: 时区
    /// - Parameter locale: 地区
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
    
    
    /// ISO标准格式格式化
    /// - Parameter dateString: 时间字符串
    func dateWithISOFormatString(_ dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter.date(from: dateString)
    }

}
