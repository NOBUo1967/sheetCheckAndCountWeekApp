//
//  WeekCount.swift
//  sheetCheckAndCountWeekApp
//
//  Created by Shinichiro Hirasawa on 2021/10/18.
//

import SwiftUI

//extension UIApplication {
//    func dissmissKeyboard() {
//        sendAction(#selector(UIResponder.resignFirstResponder),to: nil, from: nil,for: nil)
//    }
//}

struct WeekCount: View {
    @State private var startDate = Date()
    @State private var endDate = Date()
//    @State private var span = Date()
    
//    func dissmissKeyboard() {
//        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//    }
    
    
    var body: some View {
        Form {
            DatePicker("開始日", selection: $startDate, displayedComponents: .date)
                .environment(\.locale, Locale(identifier: "ja_JP"))
//                .onChange(of: startDate) { startDate in
//                    print(startDate)
//                }
//                .onChange(of: startDate, perform: {
//                    UIApplication.shared.dissmissKeyboard()
//                })
            DatePicker("終了日", selection: $endDate, displayedComponents: .date)
                .environment(\.locale, Locale(identifier: "ja_JP"))
            
            Text("original: \(startDate.description)")
            Text("original: \(endDate.description)")
            Text("\(startDate.description)から\(endDate.description)は\(calclateSpan(startDate: self.startDate, endDate: self.endDate))日")
        } // Form
    } // body
    
    // 日付の差を計算する関数
    func calclateSpan(startDate: Date, endDate: Date) -> Int {
        // 計算部分 TimeIntervalがDouble型のため差spanはDouble型で宣言
        let span:Double = endDate.timeIntervalSince(startDate)
        // TimeIntervalが秒数で与えられるため(60秒*60分*24時間)で除算して日数へ変換
        let differenceInTheNumberOfDays = span/(60*60*24)
        
        return Int(differenceInTheNumberOfDays)
    }
}

struct WeekCount_Previews: PreviewProvider {
    static var previews: some View {
        WeekCount()
    }
}
