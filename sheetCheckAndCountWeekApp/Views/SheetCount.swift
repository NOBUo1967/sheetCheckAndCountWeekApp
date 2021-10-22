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
    @State var numberPerSheet = ""
    @State var total = 0
    @State var fraction = 0.0
    
    var body: some View {
        VStack {
            HStack {
                Text("1日必要錠(包)数")
                TextField("錠", text: self.$dairyDose) // TextField
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
            } // Hstack 1日必要錠(包)数
            .padding()
            
            HStack {
                Text("日数")
                TextField("日", text: self.$numberOfDay) // TextField
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
            } // Hstack 日数
            .padding()

            HStack {
                Text("1シート(つづり)あたりの錠(包)数")
                TextField("錠", text: self.$numberPerSheet) // TextField
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
            } // Hstack
            .padding()
            
            Button(action: {
                // 必要シート数が小数点になることはありえないのでInt型にキャストしている
                self.total = Int(Double(self.dairyDose)! * Double(self.numberOfDay)! / Double(self.numberPerSheet)!)
                // 端数の錠数
                self.fraction = (Double(self.dairyDose)! * Double(self.numberOfDay)!).truncatingRemainder(dividingBy: Double(self.numberPerSheet)!)
                
                UIApplication.shared.endEditing()
            }) {
                Text("計算")
            } //Button
            .padding()
            Text("必要なヒートは\n\(self.total)シート\n+\(self.fraction)錠です")
//                .lineLimit(0)
        } // VStack
    }
}



struct SheetCount_Previews: PreviewProvider {
    static var previews: some View {
        SheetCount()
    }
}
