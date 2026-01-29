//
//  StreakCalculator.swift
//  GratefulMoments
//
//  Created by 増田創 on 2026/01/29.
//

import Foundation

struct StreakCalculator {
    let calendar = Calendar.current
    
    /// Counts the number of days in a row a moment has been saved
    ///
    /// Days are measured from the end of the day, rather than whatever time of day it is currently
    /// - precondition: `moments` must be sorted by timestamp, from earliest to latest
    func calculateStreak(for moments: [Moment]) -> Int {
        let startOfToday = calendar.startOfDay(for: .now)
        let endOfToday = calendar.date(byAdding: DateComponents(day: 1, second: -1), to: startOfToday)!
        
        // Ex. [0, 0, 1, 2, 4, 5]
        let daysAgoArray = moments
            .reversed()
            .map(\.timestamp)
            .map { calendar.dateComponents([.day], from: $0, to: endOfToday) }
            .compactMap { $0.day }
        
        var streak = 0
        for daysAgo in daysAgoArray {
            if daysAgo == streak {
                streak += 1
            }
        }
        
        return streak
    }
}
