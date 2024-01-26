//
//  QuizView.swift
//  RiskLess
//
//  Created by Akbar Khusanbaev on 26/01/24.
//

import SwiftUI

struct QuizView: View {
    @AppStorage("is_quiz_passed") private var isQuizPassed: Bool = false
    @StateObject private var quizVM = QuizViewModel()
    @Namespace var namespace
    
    var body: some View {
        VStack {
            TabView(selection: $quizVM.tabSelection, content: {
                ForEach(0..<quizVM.questions.count, id: \.self) { QuizToDisplay(index: $0).tag($0) }
            })
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .onChange(of: quizVM.isQuizComplete, perform: { newValue in
            if newValue == true {
                isQuizPassed = true
            }
        })
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    func QuizToDisplay(index: Int) -> some View {
        VStack {
            ScrollView {
                HStack {
                    Spacer()
                    Text("\(quizVM.tabSelection + 1) / \(quizVM.questions.count)")
                        .padding(5)
                        .font(.headline)
                        .background(Capsule().fill(.thinMaterial))
                }
                .padding()
                HStack {
                    Text(quizVM.questions[index].question)
                        .font(.largeTitle.bold())
                    Spacer()
                }
                .padding()
                
                HStack {
                    if quizVM.questions[quizVM.tabSelection].textField {
                        TextField("Write here(Optional)...", text: $quizVM.textFieldText, axis: .vertical)
                            .lineLimit(5)
                            .frame(maxWidth: .infinity)
                            .frame(minHeight: 45)
                            .font(.headline)
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                            .background(
                                RoundedRectangle(cornerRadius: 10.0)
                                    .fill(.thinMaterial)
                            )
                            .padding()
                    } else {
                        ForEach(0..<quizVM.questions[quizVM.tabSelection].options.count, id: \.self) { x in
                            Button(quizVM.questions[quizVM.tabSelection].options[x]) {
                                withAnimation(.bouncy) {
                                    quizVM.selectedResponse = quizVM.questions[quizVM.tabSelection].options[x]
                                }
                            }
                            .padding(8)
                            .foregroundStyle(.primary)
                            .font(.headline)
                            .background {
                                if quizVM.selectedResponse == quizVM.questions[quizVM.tabSelection].options[x] {
                                    Capsule()
                                        .fill(Color.accentColor.gradient)
                                        .matchedGeometryEffect(id: "OptionItem", in: namespace)
                                } else {
                                    Capsule()
                                        .fill(.thinMaterial)
                                }
                            }
                        }
                    }
                }
            }
            .scrollDismissesKeyboard(.immediately)
            VStack(spacing: 15) {
                Button(action: {
                    quizVM.skipped()
                }, label: {
                    Text("Skip")
                        .font(.headline)
                })
                .foregroundStyle(.secondary)
                Button(action: {
                    quizVM.next()
                }, label: {
                    HStack {
                        Text("Next")
                        Image(systemName: "chevron.right")
                    }
                    .font(.headline)
                    .frame(height: 45)
                    .padding(.horizontal, 40)
                    .background(
                        RoundedRectangle(cornerRadius: 10.0)
                            .fill(.background)
                    )
                })
                .foregroundStyle(.primary)
            }
        }
        .background(Color.accentColor.gradient.opacity(0.6))
    }
}

#Preview {
    QuizView()
}
