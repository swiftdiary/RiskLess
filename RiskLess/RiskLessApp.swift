//
//  RiskLessApp.swift
//  RiskLess
//
//  Created by Akbar Khusanbaev on 26/01/24.
//

import SwiftUI

@main
struct RiskLessApp: App {
    @AppStorage("is_signed_in") private var isSignedIn: Bool = false
    @AppStorage("is_quiz_passed") private var isQuizPassed: Bool = false
    @AppStorage("is_premium") private var isPremium: Bool = false
    
    var body: some Scene {
        WindowGroup {
            Group {
                if isSignedIn {
                    if isQuizPassed {
                        ContentView()
                    } else {
                        QuizView()
                    }
                } else {
                    AuthView()
                }
            }
            .onAppear(perform: {
//                isSignedIn = false
//                isQuizPassed = false
            })
        }
    }
}
