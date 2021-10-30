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
    
//    func dissmissKeyboard() {
//        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//    }
    
    
    var body: some View {
        Form {
            DatePicker("開始日", selection: $startDate, displayedComponents: .date)
                .environment(\.locale, Locale(identifier: "ja_JP"))
                .datePickerStyle(WheelDatePickerStyle())
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
        } // Form
    } // body
}

struct WeekCount_Previews: PreviewProvider {
    static var previews: some View {
        WeekCount()
    }
}
