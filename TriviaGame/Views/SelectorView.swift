//
//  SelectorView.swift
//  TriviaGame
//
//  Created by Marcela Hernandez on 20/3/25.
//

import SwiftUI

struct SelectorView: View {
    
    @State private var difficulty = "easy"
    @State private var category = "9"
    @State private var amount = 10
    
    @State private var navigateToTrivia = false
    @StateObject var triviaManager = TriviaManager()
    
    let difficulties = ["easy", "medium", "hard"]
    let categories = [
        "General Knowledge": "9",
        "Books": "10",
        "Movies": "11",
        "Music": "12",
        "Musical & Theatres": "13",
        "Television": "14",
        "Video Games": "15",
        "Board Games": "16",
        "Science & Nature": "17",
        "Computer": "18",
        "Mathematics": "19",
        "Mythology": "20",
        "Sports": "21",
        "Geography": "22",
        "History" : "23",
        "Politics": "24",
        "Art": "25",
        "Celebrities": "26",
        "Animals": "27",
        "Vehicles": "28",
        "Comics": "29",
        "Gadgets": "30",
        "Anime & Manga": "31",
        "Cartoon & Animations": "32"
    ]
    let questionAmount = [5, 10, 15, 20, 25, 50]
    
    var body: some View {
        NavigationView {
            
            ZStack {
                
                Image(.backgroundPhoto)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                VStack {
                    
                    Text("Quiz Settings").formattedTitle()
                        .foregroundStyle(.white)
                        .padding()
                    
                    Spacer()
                    
                    VStack(spacing: 20) {
                        
                        // Difficulty
                        HStack {
                            Text("Difficulty:")
                                .font(.title2)
                                .fontWeight(.heavy)
                                .foregroundStyle(.white)
                            Spacer()
                            Picker("Difficulty", selection: $difficulty) {
                                ForEach(difficulties, id: \.self) { difficulty in
                                    Text(difficulty).tag(difficulty)
                                }
                            }
                        }
                        .padding(35)
                        
                        // Category
                        HStack {
                            Text("Category:")
                                .font(.title2)
                                .fontWeight(.heavy)
                                .foregroundStyle(.white)
                            Spacer()
                            Picker("Category", selection: $category) {
                                ForEach(categories.keys.sorted(), id: \.self) { category in
                                    Text(category).tag(categories[category]!)
                                }
                            }
                            
                        }
                        .padding(35)
                        
                        HStack {
                            Text("Question Number:")
                                .font(.title2)
                                .fontWeight(.heavy)
                                .foregroundStyle(.white)
                            Spacer()
                            
                            
                            
                            
                            Picker("Question Number", selection: $amount) {
                                ForEach(questionAmount, id: \.self) { amount in
                                    Text("\(amount)").tag(amount)
                                }
                            }
                        }
                        .padding(35)
                        
                        
                    }
                    .padding()
                    
                    Spacer()
                    
                    NavigationLink(destination: TriviaView().environmentObject(triviaManager)
                        .onAppear() {
                            Task {
                                await triviaManager.fetchTrivia(difficulty: difficulty, category: category, amount: amount)
                                saveSettings()
                            }
                        }
                    ) {
                        PrimaryButton(text: "Start Quiz")
                    }
                        
                    
//                    Button {
//                        Task {
//                            await triviaManager.fetchTrivia(difficulty: difficulty.lowercased(), category: category, amount: amount)
//                            navigateToTrivia = true
//                        }
//                    } label: {
//                        PrimaryButton(text: "Start Quiz!")
//                    }
                    
                }
            }
        }
        
    }
    
    func saveSettings() {
        UserDefaults.standard.set(difficulty.lowercased(), forKey: "difficulty")
        UserDefaults.standard.set(category, forKey: "category")
        UserDefaults.standard.set(amount, forKey: "amount")
    }
}



#Preview {
    SelectorView()
}
