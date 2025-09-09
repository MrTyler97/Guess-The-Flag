//
//  ContentView.swift
//  Guess The Flag
//
//  Created by Vic  on 5/15/25.
//

// Different view stacks, Vstack -> vertical view, Hstack -> horizontal view, Zstack -> depth view - layers views (adding text over an image)
//.ignoreSafeArea allow you to fill entire screen
//.background(.ultrThinMaterial) is used often in Swfit UI for frosted window effect.
//Gradients -> LinearGradient (Goes in one direction),              RadialGradient(Outward circle),AngularGradient(Cycles around point) '.gradient' is used often in swift to make designs better. Use this after any color
// Images - > Image(decorative: "nameOfFile") the files would be stored in assets. 'systemName:' -> uses Apple’s SF Symbols icon collection, and you can search for icons you like
// Alerts - > .alert() creates a pop up on the screen.
//.ignoreSafeArea allow you to fill entire screen
//.background(.ultrThinMaterial) is used often in Swfit UI for frosted window effect.
import SwiftUI
struct ContentView: View {
    
    @State private var countries = ["Estonia", "Germany", "Italy", "France", "Spain", "UK", "Ukraine", "Nigeria", "US", "Poland", "Ireland"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var totalScore = 0
    @State private var numberOfClicks = 0
    @State private var showingScore = false
    @State private var scoreTitle: String = ""
    
    func flagTapped(_ number: Int) {
        numberOfClicks += 1
        if number == correctAnswer {
            scoreTitle = "Correct"
            totalScore += 1
        } else {
            scoreTitle = "Incorrect"
        }
        showingScore.toggle()
    }
    
    func askQuestions(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    // Creating a struct to modularize code
    struct FlagImage: View {
        //Our parameter
        var text: String
        // Logic for showing flag
        var body: some View {
            Image(text)
            .clipShape(.capsule)
            .shadow(radius: 7)
        }
    }
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [.indigo, .mint], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing: 30){
                VStack{
                    Text("Tap the flag of")
                        .foregroundStyle(.white)
                        .font(.subheadline.weight(.heavy))
                    
                    Text(countries[correctAnswer])
                        .font(.largeTitle.weight(.semibold))
                        .foregroundStyle(.white)
                }
                ForEach(0..<3){ number in
                    Button {
                        flagTapped(number)
                    }label: {
                        // Uses name in array as name of file to show image
                        FlagImage(text: countries[number])
                        // ^^ Using a struct to modularized the logic.
                    }
                }
            }
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestions)
        } message: {
            Text("Your score is: " + String(totalScore) + "/" + String(numberOfClicks))
        }
    }
}

#Preview {
    ContentView()
}
