//
//  SheetCount.swift
//  sheetCheckAndCountWeekApp
//
//  Created by Shinichiro Hirasawa on 2021/10/18.
//

import SwiftUI

//extension UIApplication {
//    func closeKeyboard() {
//        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//    }
//}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder),to: nil, from: nil,for: nil)
    }
}

struct SheetCount: View {
    @State var dairyDose = 0
    @State var numberOfDay = 0
    @State var total = 0
    
    var body: some View {
        VStack {
            HStack {
                Text("1日必要錠(包)数")
                TextField("錠", value: self.$dairyDose, formatter: NumberFormatter()) // TextField
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
            } // Hstack
            .padding()
            
            HStack {
                Text("日数")
                TextField("日", value: self.$numberOfDay, formatter: NumberFormatter()) // TextField
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
            } // Hstack
            .padding()
            
            Button(action: {
                print($dairyDose)
                print($numberOfDay)
                self.total = self.dairyDose * self.numberOfDay
                UIApplication.shared.endEditing()
                
            }) {
                Text("計算")
            }
            .padding()
            Text("\(self.total)")
        } // VStack
    }
}



struct SheetCount_Previews: PreviewProvider {
    static var previews: some View {
        SheetCount()
    }
}
