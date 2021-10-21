//
//  SheetCount.swift
//  sheetCheckAndCountWeekApp
//
//  Created by Shinichiro Hirasawa on 2021/10/18.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder),to: nil, from: nil,for: nil)
    }
}

struct SheetCount: View {
    @State var dairyDose = ""
    @State var numberOfDay = ""
    @State var total = 0
    
    var body: some View {
        VStack {
            HStack {
                Text("1日必要錠(包)数")
                TextField("錠", text: self.$dairyDose) // TextField
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
            } // Hstack
            .padding()
            
            HStack {
                Text("日数")
                TextField("日", text: self.$numberOfDay) // TextField
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
            } // Hstack
            .padding()
            
            Button(action: {
                self.total = Int(self.dairyDose)! * Int(self.numberOfDay)!
                
                UIApplication.shared.endEditing()
            }) {
                Text("計算")
            } //Button
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
