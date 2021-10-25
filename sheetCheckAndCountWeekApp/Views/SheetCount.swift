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
    // 各入力値。TextFieldから値を受け取るためString型とする
    @State var dairyDose: String = ""
    @State var numberOfDay: String = ""
    @State var numberPerSheet: String = ""
    // 必要ヒート数。整数値しかありえないためInt型とする
    @State var total: Int = 0
    // あまり錠数。端数はあり得るためDouble型とする
    @State var fraction: Double = 0.0
    
    var body: some View {
        VStack {
            HStack {
                Text("1日必要錠(包)数")
                TextField("錠", text: self.$dairyDose)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad) // TextField
            } // Hstack 1日必要錠(包)数
            .padding()
            
            HStack {
                Text("日数")
                TextField("日", text: self.$numberOfDay)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad) // TextField
            } // Hstack 日数
            .padding()

            HStack {
                Text("1シート(つづり)あたりの錠(包)数")
                TextField("錠", text: self.$numberPerSheet)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad) // TextField
            } // Hstack
            .padding()
            
            Button(action: {
                // キャストしてOptional型にしておかないとif let文で、nilチェックできないため、ここで値をDouble型にキャストしておく
                let dairyDoseDouble:Double? = Double(dairyDose)
                let numberOfDayDouble:Double? = Double(numberOfDay)
                let numberPerSheetDouble: Double? = Double(numberPerSheet)
                // 各値のnilチェックと空文字チェック
                if let dairyDose = dairyDoseDouble, let numberOfDay = numberOfDayDouble, let numberPerSheet = numberPerSheetDouble, numberPerSheet != 0 {
                    self.total = Int(dairyDose * numberOfDay / numberPerSheet)
                    self.fraction = (dairyDose * numberOfDay).truncatingRemainder(dividingBy: numberPerSheet)
                    print(total)
                } else {
                    print("値を入力してください")
                }

                UIApplication.shared.endEditing()
            }) {
                Text("計算")
            } //Button
            .padding()
            // 端数は小数点第二位まで表示する。1回0.25錠までが現実的なところ。
            Text("必要なヒートは\n\(self.total)シート\n+\(String(format: "%.2f", self.fraction))錠です")
//                .lineLimit(0)
        } // VStack
    }
}



struct SheetCount_Previews: PreviewProvider {
    static var previews: some View {
        SheetCount()
    }
}
