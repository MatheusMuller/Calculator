//
//  ContentView.swift
//  Calculator
//
//  Created by Matheus Müller on 23/11/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var values = "0"
    @State var result = 0.0
    @State var previous = 0.0
    @State var hasDecimal = 0.0
    @State var operation = 0
    @State var previousOperation = 0
    
    func addNumbers(digit: Int) {
        if operation > 0 {
            result = 0
            previousOperation = operation
            operation = -1
        }
        
        if hasDecimal > 0.0 {
            result = result + Double(truncating: NSNumber(value: (Double(digit) / hasDecimal)))
            hasDecimal = hasDecimal * 10
            values = "\(values)\(digit)"
        } else {
            result = (result * 10) + Double(digit)
            values = removeDecimal(value: result)
        }
    }
    
    func calculate() {
        if previousOperation == 1 { // Sum (+)
            result = previous + result
            previousOperation = 0
        } else if previousOperation == 2 { // Subtract (-)
            result = previous - result
            previousOperation = 0
        } else if previousOperation == 3 { // Multiply (X)
            result = previous * result
            previousOperation = 0
        } else if previousOperation == 4 { // Divide (/)
            result = previous / result
            previousOperation = 0
        }
        hasDecimal = 0.0
        previous = result
        values = removeDecimal(value: result)
    }
    
    func reset() {
        result = 0
        operation = 0
        previousOperation = 0
        previous = 0
        hasDecimal = 0
        values = "0"
    }
    
    func removeDecimal(value: Double) -> String {
        let f = NumberFormatter()
        let number = NSNumber(value: value) // Transform Double in NSNumber to use in a String later
        f.minimumFractionDigits = 0
        f.maximumFractionDigits = 16
        return f.string(from: number) ?? ""
    }
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
        // spacing = 0 remove espaçamento entre as linhas e trailing joga o conteúdo para o final da linha
            
            Spacer()
            HStack {
                Text(values)
                    .padding()
                    .lineLimit(1) // Define a quantidade de linhas no bloco
                    .font(.system(size: CGFloat(80 / Int((Double(String(result).count + 10) / 8.0))))) // Vai diminuindo o tamanho da fonte
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity)
                    .fixedSize(horizontal: true, vertical: false) // Corrige a largura, jogou o número à direita
            }
            
            HStack(spacing: 0) {
                Button("AC") {
                    reset()
                }.padding()
                 .frame(maxWidth: .infinity) // utiliza todo o espaço disponível
                
                Button("+/-") {
                    result = result * -1
                    calculate()
                }.padding()
                 .frame(maxWidth: .infinity)
                
                Button("%") {
                    result = result / 100
                    calculate()
                }.padding()
                 .frame(maxWidth: .infinity)
                
                Button("/") {
                    calculate()
                    operation = 4
                }.padding(.vertical, 40)
                 .frame(maxWidth: .infinity)
                 .background(Color.orange)
                
            }.foregroundColor(Color.white)
            
            HStack(spacing: 0) {
                Button("7") {
                    addNumbers(digit: 7)
                }.padding()
                 .frame(maxWidth: .infinity) // utiliza todo o espaço disponível
                
                Button("8") {
                    addNumbers(digit: 8)
                }.padding()
                 .frame(maxWidth: .infinity)
                
                Button("9") {
                    addNumbers(digit: 9)
                }.padding()
                 .frame(maxWidth: .infinity)
                
                Button("X") {
                    calculate()
                    operation = 3
                }.padding(.vertical, 40)
                 .frame(maxWidth: .infinity)
                 .background(Color.orange)
                
            }.foregroundColor(Color.white)
            
            HStack(spacing: 0) {
                Button("4") {
                    addNumbers(digit: 4)
                }.padding()
                 .frame(maxWidth: .infinity)
                
                Button("5") {
                    addNumbers(digit: 5)
                }.padding()
                 .frame(maxWidth: .infinity)
                
                Button("6") {
                    addNumbers(digit: 6)
                }.padding()
                 .frame(maxWidth: .infinity)
                
                Button("-") {
                    calculate()
                    operation = 2
                }.padding(.vertical, 40)
                 .frame(maxWidth: .infinity)
                 .background(Color.orange)
                
            }.foregroundColor(Color.white)
            
            HStack(spacing: 0) {
                Button("1") {
                    addNumbers(digit: 1)
                }.padding()
                 .frame(maxWidth: .infinity)
                
                Button("2") {
                    addNumbers(digit: 2)
                }.padding()
                 .frame(maxWidth: .infinity)
                
                Button("3") {
                    addNumbers(digit: 3)
                }.padding()
                 .frame(maxWidth: .infinity)
                
                Button("+") {
                    calculate()
                    operation = 1
                }.padding(.vertical, 40)
                 .frame(maxWidth: .infinity)
                 .background(Color.orange)
                
            }.foregroundColor(Color.white)
            
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    Button("0") {
                        addNumbers(digit: 0)
                    }.padding()
                        .frame(minWidth: geometry.size.width / 2)
                    
                    Button(".") {
                        if hasDecimal == 0.0 {
                            hasDecimal = 10.0
                            values = values + "."
                        }
                    }.padding()
                     .frame(maxWidth: .infinity)
                    
                    Button("=") {
                        calculate()
                        previousOperation = 111 // Using a value that will never be used to reset
                        operation = 111 // Resets all past operations
                    }.padding(.vertical, 40)
                     .frame(maxWidth: .infinity)
                     .background(Color.orange)
                    
                }.foregroundColor(Color.white)
            }.frame(maxHeight: 92)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
