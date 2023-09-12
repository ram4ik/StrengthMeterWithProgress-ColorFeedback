//
//  ContentView.swift
//  StrengthMeterWithProgress&ColorFeedback
//
//  Created by Ramill Ibragimov on 11.09.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var text: String = ""
    @State private var progress: CGFloat = 0.0
    @State private var checkMinChars = false
    @State private var checkLetter = false
    @State private var checkPunctuation = false
    @State private var checkNumber = false
    @State private var showPassword = false
    
    var progressColor: Color {
        let containsLetters = text.rangeOfCharacter(from: .letters) != nil
        let containsNumber = text.rangeOfCharacter(from: .decimalDigits) != nil
        let containsPunctuation = text.rangeOfCharacter(from: CharacterSet(charactersIn: "!@#$%^&*")) != nil
        if containsLetters && containsNumber && containsPunctuation && text.count >= 8 {
            return Color.green
        } else if containsLetters && !containsNumber && !containsPunctuation {
            return Color.red
        } else if !containsLetters && containsNumber && !containsPunctuation {
            return Color.red
        } else if containsLetters && containsNumber && !containsPunctuation {
            return Color.yellow
        } else if containsLetters && containsNumber && containsPunctuation {
            return Color.blue
        } else {
            return Color.gray
        }
    }
    
    var body: some View {
        ZStack {
            TextField("Password", text: $text)
                .padding(.leading)
                .bold()
                .onChange(of: text, perform: { newValue in
                    withAnimation {
                        progress = min(1.0, max(0, CGFloat(newValue.count) / 8.0))
                    }
                })
                .frame(height: 60)
                .background(RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 10, y: 4)
                )
            
            RoundedRectangle(cornerRadius: 10)
                .trim(from: 0, to: progress)
                .stroke(progressColor, lineWidth: 3)
                .frame(height: 60)
                .rotationEffect(.degrees(-180))
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
