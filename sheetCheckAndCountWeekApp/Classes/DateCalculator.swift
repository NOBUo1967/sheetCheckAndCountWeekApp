//
//  DateCalculator.swift
//  sheetCheckAndCountWeekApp
//
//  Created by Shinichiro Hirasawa on 2022/01/10.
//

import Foundation
class DateCalculator {
    // 指定した日付の時間をリセットする関数
    // 0401 23:59と0402 0:00のようなケースでは計算がうまく行かないため実装
    func resetTime(date: Date) -> Date {
        
        let calendar: Calendar = Calendar(identifier: .gregorian)
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        components.hour = 0
        components.minute = 0
        components.second = 0
        
        return calendar.date(from: components)!
    }
    
    // 日付の差を計算する関数
    // 開始日を含むか否かは使用するファイルによって異なるためデフォルト値を設定しておく
    func calclateSpan(startDate: Date, endDate: Date, includestartDate: Bool = false) -> Int {
        // 入力値の時間をリセット
        let resetTimeStartDate = resetTime(date: startDate)
        let resteTImeEndDate = resetTime(date: endDate)
        
        // 計算部分 TimeIntervalがDouble型のため差spanはDouble型で宣言
        let span:Double = resteTImeEndDate.timeIntervalSince(resetTimeStartDate)
        
        // TimeIntervalが秒数で与えられるため(60秒*60分*24時間)で除算して日数へ変換
        // 下記の開始日を含むか否かの判定で値が変更しうるためvarで宣言
        var differenceInTheNumberOfDays = span/(60*60*24)
        
        // 開始日を含むか否かのtoggleがオンのときは計算結果に+1をする
        if includestartDate == true {
            
            differenceInTheNumberOfDays += 1
        }
        
        return Int(differenceInTheNumberOfDays)
    }
}
