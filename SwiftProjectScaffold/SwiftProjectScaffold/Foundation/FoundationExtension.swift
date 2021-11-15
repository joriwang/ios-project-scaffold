//
//  FoundationExtension.swift
//  ChongYaProjectScaffold
//
//  Created by Jori on 2021/11/9.
//

import Foundation

extension String {
    func convertNSRange(_ range: NSRange) -> Range<String.Index> {
        return self.index(self.startIndex, offsetBy: range.location)..<self.index(self.startIndex, offsetBy: range.location + range.length)
    }

    func latin() -> String {
        let string = NSMutableString(string: self) as CFMutableString
        let range = UnsafeMutablePointer<CFRange>.allocate(capacity: 1)
        range.pointee = CFRange(location: 0, length: self.count)
        _ = CFStringTransform(string, range, kCFStringTransformToLatin, false)
        return string as String
    }

    func lationWithoutDiacritics() -> String {
        let string = NSMutableString(string: self) as CFMutableString
        let range = UnsafeMutablePointer<CFRange>.allocate(capacity: 1)
        range.pointee = CFRange(location: 0, length: self.count)
        _ = CFStringTransform(string, range, kCFStringTransformToLatin, false)
        let preResultString = string as String
        let result = NSMutableString(string: preResultString) as CFMutableString
        range.pointee = CFRange(location: 0, length: preResultString.count)
        _ = CFStringTransform(result, range, kCFStringTransformStripDiacritics, false)
        return result as String
    }
}

extension Calendar {
    func monthStartDate(_ date: Date) -> Date {
        let components = self.dateComponents([.year, .month, .day], from: date)
        var startDayComponents = DateComponents()
        startDayComponents.day = 1
        startDayComponents.month = components.month
        startDayComponents.year = components.year
        return self.date(from: startDayComponents)!
    }

    func monthEndDate(_ date: Date) -> Date {
        let components = self.dateComponents([.year, .month, .day], from: date)
        var endDayComponents = DateComponents()
        endDayComponents.day = -1
        endDayComponents.month = components.month == 12 ? 1 : (components.month! + 1)
        endDayComponents.year = components.month == 12 ? (components.year! + 1) : components.year
        return self.date(from: endDayComponents)!
    }

    func monthDayCount(_ date: Date) -> Int {
        let startDate = self.monthStartDate(date)
        let endDate = self.monthEndDate(date)

        let diff = self.dateComponents([.day], from: startDate, to: endDate)
        return diff.day!
    }

    func weekStartDay(_ date: Date) -> Date {
        let weekday = self.component(.weekday, from: date)
        return Date(timeIntervalSince1970: date.timeIntervalSince1970 - (Double(weekday) - 1) * 3600 * 24)
    }

    func weekEndDay(_ date: Date) -> Date {
        let weekday = self.component(.weekday, from: date)
        return Date(timeIntervalSince1970: date.timeIntervalSince1970 + (7 - Double(weekday)) * 3600 * 24)
    }
}
