//
//  WeekCount.swift
//  sheetCheckAndCountWeekApp
//
//  Created by Shinichiro Hirasawa on 2021/10/18.
//

import SwiftUI

struct WeekCount: View {
    @State var startDate = Date()
    @State var endDate = Date()
    
    var body: some View {
        Form {
            DatePicker("開始日", selection: $startDate, displayedComponents: .date)
                .environment(\.locale, Locale(identifier: "ja_JP"))
            DatePicker("終了日", selection: $endDate, displayedComponents: .date)
                .environment(\.locale, Locale(identifier: "ja_JP"))
            
            Text("original: \(startDate.description)")
            Text("original: \(endDate.description)")
        }
    }
}

struct WeekCount_Previews: PreviewProvider {
    static var previews: some View {
        WeekCount()
    }
}
