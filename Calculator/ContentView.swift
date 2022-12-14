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
        // spacing = 0 removes line spacing and trailing throws content to the end of the line
            
            Spacer()
            HStack {
                Text(values)
                    .padding()
                    .lineLimit(1) // Defines the number of lines in the block
                    .font(.system(size: CGFloat(80 / Int((Double(String(result).count + 10) / 8.0))))) // It decreases the font size
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity)
                    .fixedSize(horizontal: true, vertical: false) // Fix the width, put the number on the right
            }
            
            HStack(spacing: 0) {
                Button("AC") {
                    reset()
                }.padding()
                 .frame(maxWidth: .infinity) // Uses all available space
                 .font(.system(size: 30)) // Increasing button font size
                
                Button("+/-") {
                    result = result * -1
                    calculate()
                }.padding()
                 .frame(maxWidth: .infinity)
                 .font(.system(size: 30))
                
                Button("%") {
                    result = result / 100
                    calculate()
                }.padding()
                 .frame(maxWidth: .infinity)
                 .font(.system(size: 30))
                
                Button("/") {
                    calculate()
                    operation = 4
                }.padding(.vertical, 30)
                 .font(.system(size: 30))
                 .frame(maxWidth: .infinity)
                 .background(Color.orange)
                
            }.foregroundColor(Color.white)
            
            HStack(spacing: 0) {
                Button("7") {
                    addNumbers(digit: 7)
                }.padding()
                 .frame(maxWidth: .infinity)
                 .font(.system(size: 30))
                
                Button("8") {
                    addNumbers(digit: 8)
                }.padding()
                 .frame(maxWidth: .infinity)
                 .font(.system(size: 30))
                
                Button("9") {
                    addNumbers(digit: 9)
                }.padding()
                 .frame(maxWidth: .infinity)
                 .font(.system(size: 30))
                
                Button("x") {
                    calculate()
                    operation = 3
                }.padding(.vertical, 30)
                 .font(.system(size: 30))
                 .frame(maxWidth: .infinity)
                 .background(Color.orange)
                
            }.foregroundColor(Color.white)
            
            HStack(spacing: 0) {
                Button("4") {
                    addNumbers(digit: 4)
                }.padding()
                 .frame(maxWidth: .infinity)
                 .font(.system(size: 30))
                
                Button("5") {
                    addNumbers(digit: 5)
                }.padding()
                 .frame(maxWidth: .infinity)
                 .font(.system(size: 30))
                
                Button("6") {
                    addNumbers(digit: 6)
                }.padding()
                 .frame(maxWidth: .infinity)
                 .font(.system(size: 30))
                
                Button("-") {
                    calculate()
                    operation = 2
                }.padding(.vertical, 30)
                 .font(.system(size: 30))
                 .frame(maxWidth: .infinity)
                 .background(Color.orange)
                
            }.foregroundColor(Color.white)
            
            HStack(spacing: 0) {
                Button("1") {
                    addNumbers(digit: 1)
                }.padding()
                 .frame(maxWidth: .infinity)
                 .font(.system(size: 30))
                
                Button("2") {
                    addNumbers(digit: 2)
                }.padding()
                 .frame(maxWidth: .infinity)
                 .font(.system(size: 30))
                
                Button("3") {
                    addNumbers(digit: 3)
                }.padding()
                 .frame(maxWidth: .infinity)
                 .font(.system(size: 30))
                
                Button("+") {
                    calculate()
                    operation = 1
                }.padding(.vertical, 30)
                 .font(.system(size: 30))
                 .frame(maxWidth: .infinity)
                 .background(Color.orange)
                
            }.foregroundColor(Color.white)
            
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    Button("0") {
                        addNumbers(digit: 0)
                    }.padding()
                        .frame(minWidth: geometry.size.width / 2)
                        .font(.system(size: 30))
                    
                    Button(".") {
                        if hasDecimal == 0.0 {
                            hasDecimal = 10.0
                            values = values + "."
                        }
                    }.padding()
                     .frame(maxWidth: .infinity)
                     .font(.system(size: 30))
                    
                    Button("=") {
                        calculate()
                        previousOperation = 111 // Using a value that will never be used to reset
                        operation = 111 // Resets all past operations
                    }.padding(.vertical, 30)
                        .font(.system(size: 30))
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
