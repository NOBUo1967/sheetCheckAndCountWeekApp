//
//  DaysCount.swift
//  sheetCheckAndCountWeekApp
//
//  Created by Shinichiro Hirasawa on 2021/10/18.
//

import SwiftUI

struct DaysCount: View {
    @State private var startDate = Date()
    @State private var endDate = Date()
    
    var body: some View {
        VStack {
            // 日付を選択する領域
            Text("服用開始日").font(.title2)
            DatePicker("服用開始日", selection: $startDate, displayedComponents: .date)
                .environment(\.locale, Locale(identifier: "ja_JP"))
                .labelsHidden()
                .padding(.bottom, 30)
            
            Text("次回受診日").font(.title2)
            DatePicker("次回受診日", selection: $endDate, displayedComponents: .date)
                .environment(\.locale, Locale(identifier: "ja_JP"))
                .labelsHidden()
                .padding(.bottom, 60)
            
            // 計算結果を表示する領域
            Text("次回受診日まで").font(.title2)
            Text("\(calclateSpan(startDate: self.startDate, endDate: self.endDate))日分").font(.title).foregroundColor(.red)
            Text("必要です").font(.title2)
        } // VStack
    } // body
    
    
    // 指定した日付の時間をリセットする関数
    func resetTime(date: Date) -> Date {
        let calendar: Calendar = Calendar(identifier: .gregorian)
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        components.hour = 0
        components.minute = 0
        components.second = 0
        
        return calendar.date(from: components)!
    }
    
    // 日付の差を計算する関数
    func calclateSpan(startDate: Date, endDate: Date) -> Int {
        let resetTimeStartDate = resetTime(date: startDate)
        let resteTImeEndDate = resetTime(date: endDate)
        
        // 計算部分 TimeIntervalがDouble型のため差spanはDouble型で宣言
        let span:Double = resteTImeEndDate.timeIntervalSince(resetTimeStartDate)
        // TimeIntervalが秒数で与えられるため(60秒*60分*24時間)で除算して日数へ変換
        // 計算結果が1日分少ないため1を足している
        let differenceInTheNumberOfDays = span/(60*60*24) + 1
        
        return Int(differenceInTheNumberOfDays)
    }
}

struct DaysCount_Previews: PreviewProvider {
    static var previews: some View {
        DaysCount()
    }
}
