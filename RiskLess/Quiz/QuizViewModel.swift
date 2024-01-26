//
//  QuizViewModel.swift
//  RiskLess
//
//  Created by Akbar Khusanbaev on 26/01/24.
//

import SwiftUI

final class QuizViewModel: ObservableObject {
    @Published var questions: [QuizQuestion] = [
        .init(question: "I am ...", options: ["Student", "Researcher", "Investor", "Other..."]),
        .init(question: "Placement of Study/Work", options: [], textField: true),
        .init(question: "Purpose of using", options: [], textField: true)
    ]
    @Published var responses: [LocalizedStringKey] = []
    
    @Published var isQuizComplete: Bool = false
    
    @Published var tabSelection: Int = 0 {
        didSet {
            if tabSelection < oldValue { // Scenario 1: If user scrolled back
                Task {
                    await MainActor.run {
                        _ = self.responses.popLast()
                    }
                }
            } else {
                if tabSelection + 1 > self.responses.count {
                    if self.textFieldText.isEmpty {
                        self.responses.append(LocalizedStringKey("Skipped"))
                        self.selectedResponse = ""
                        self.textFieldText = ""
                    } else {
                        self.responses.append(LocalizedStringKey(self.textFieldText))
                        self.selectedResponse = ""
                        self.textFieldText = ""
                    }
                }
            }
        }
    }

    @Published var textFieldText: String = ""
        
    @Published var selectedResponse: LocalizedStringKey = ""
    
    @MainActor
    func next() {
        if questions[tabSelection].textField {
            withAnimation(.bouncy) {
                self.responses.append(LocalizedStringKey(textFieldText))
                self.textFieldText = ""
                if tabSelection + 1 == self.questions.count {
                    self.respondedAllQuestions()
                } else {
                    self.tabSelection += 1
                }
            }
        } else {
            withAnimation(.bouncy) {
                self.responses.append(selectedResponse)
                self.selectedResponse = ""
                if tabSelection + 1 == self.questions.count {
                    self.respondedAllQuestions()
                } else {
                    self.tabSelection += 1
                }
            }
        }
    }
    
    @MainActor
    func skipped() {
        withAnimation(.bouncy) {
            self.responses.append(LocalizedStringKey("Skipped"))
            self.selectedResponse = ""
            self.textFieldText = ""
            if tabSelection + 1 == self.questions.count {
                self.respondedAllQuestions()
            } else {
                self.tabSelection += 1
            }
        }
    }
    
    func respondedAllQuestions() {
        // call server
        Task {
            await MainActor.run {
                self.isQuizComplete = true
            }
        }
    }
    
}

struct QuizQuestion: Identifiable {
    let id = UUID()
    let question: LocalizedStringKey
    let options: [LocalizedStringKey]
    let textField: Bool
    init(question: LocalizedStringKey, options: [LocalizedStringKey], textField: Bool = false) {
        self.question = question
        self.options = options
        self.textField = textField
    }
}

