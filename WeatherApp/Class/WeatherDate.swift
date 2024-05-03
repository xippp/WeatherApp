//
//  Date.swift
//  WeatherApp
//
//  Created by Paul on 3/5/2567 BE.
//

import Foundation

class WeatherDate {
    
    func formatDateString(dates: [String]) -> (dateName: [String], shortDate: [String]) {
        let formatterDate = DateFormatter()
        var dates2: [Date] = []
        var dateName: [String] = []
        var shortDate: [String] = []
        formatterDate.dateFormat = "yyyy-MM-dd"
        formatterDate.locale = Locale(identifier: "en_UK")
        formatterDate.calendar = Calendar(identifier: .gregorian)
//        formatterDate.timeZone = TimeZone(abbreviation: "GMT+7:00")
        formatterDate.timeZone = TimeZone(identifier: "Asia/Bangkok")
        var sumDates: [String: String] = [:]
        for date in dates {
            dates2.append(formatterDate.date(from: date)!)
        }
        
        let formatterString = DateFormatter()
        formatterString.dateFormat = "d/M EEEE"
        formatterString.locale = Locale(identifier: "en_UK")
        formatterString.calendar = Calendar(identifier: .gregorian)
//        formatterString.timeZone = TimeZone(abbreviation: "GMT+7:00")
        formatterString.timeZone = TimeZone(identifier: "Asia/Bangkok")
        for date in dates2 {
            let dateStr = formatterString.string(from: date)
            let substrings = dateStr.split(separator: " ")
            if isDateToday(date: date) {
                dateName.append("Today")
            } else if isDateTomorrow(inputDate: date) {
                dateName.append("Tomorrow")
            } else {
                dateName.append(String(substrings[1]))
            }
            shortDate.append(String(substrings[0]))
        }
        return (dateName, shortDate)
    }
    
    func isDateToday(date: Date) -> Bool {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let otherDate = calendar.startOfDay(for: date)
        return today == otherDate
    }
    
    func isDateTomorrow(inputDate: Date) -> Bool {
        let calendar = Calendar.current
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: Date())!
        
        let inputDateComponents = calendar.dateComponents([.year, .month, .day], from: inputDate)
        let tomorrowComponents = calendar.dateComponents([.year, .month, .day], from: tomorrow)
        
        return inputDateComponents == tomorrowComponents
    }
    
}
