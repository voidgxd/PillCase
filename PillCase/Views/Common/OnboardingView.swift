//
//  OnboardingView.swift
//  PillCase
//
//  Created by Максим Мосалёв on 31.03.2023.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var showOnboarding: Bool
    @State private var currentPageIndex = 0
    
    var body: some View {
        TabView(selection: $currentPageIndex) {
            OnboardingPage(imageName: "OScourses", color: CustomColor.day, title: "Welcome to PillCase", description: "Start by adding a new course of medication.To do this, use the + button in the Courses tab")
                .tag(0)
            OnboardingPage(imageName: "OSnewCourse", color: CustomColor.evening, title: "Set Up Your Course", description: "Customize your medication time, dosage, course duration, and more. Choose colors and icons for easy tracking.")
                .tag(1)
            OnboardingPage(imageName: "OScalendar", color: CustomColor.night, title: "Track with a Сalendar", description: "Convenient tracking of your medications. Switch the calendar to track your courses progress or time of day.")
                .tag(2)
            OnboardingPage(imageName: "OStoday", color: CustomColor.night, title: "Take Your Medicine for Today", description: "Mark the taken medications by holding it.")
                .tag(3)
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .onAppear {
            // When the onboarding view appears, set the hasSeenOnboarding user default to true
            UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
        }
        .overlay(
            Button(action: {
                self.showOnboarding = false
            }) {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .fontWeight(.semibold)
            }
                .foregroundColor(.white)
                .padding(10)
                .background(CustomColor.morning)
                .clipShape(Circle())
                .padding(.trailing, 20)
                .padding(.top, 50),
            alignment: .topTrailing
            
        )
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(showOnboarding: .constant(false))
    }
}

struct OnboardingPage: View {
    let imageName: String
    let color: Color
    let title: String
    let description: String
    
    var body: some View {
        VStack(spacing: 20) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .padding()
            
            Text(title)
                .font(.title)
                .fontWeight(.semibold)
            Text(description)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
        }
    }
}


