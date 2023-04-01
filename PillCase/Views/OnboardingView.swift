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
            OnboardingPage(imageName: "onboarding-image-1", color: CustomColor.day, title: "Welcome to MyApp", description: "Get started with MyApp by creating an account today.")
                .tag(0)
            OnboardingPage(imageName: "onboarding-image-2", color: CustomColor.evening, title: "Find Your Dream Job", description: "With MyApp, you can easily search and apply for jobs that match your skills and experience.")
                .tag(1)
            OnboardingPage(imageName: "onboarding-image-3", color: CustomColor.night, title: "Stay Connected", description: "Stay in touch with your coworkers and get updates on job postings with MyApp's built-in messaging feature.")
                .tag(2)
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
                Text("X")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            .foregroundColor(.white)
            .padding()
            .background(CustomColor.night)
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

struct OnboardingCardView: View {
    var body: some View {
        ZStack {
            
        }
        .foregroundColor(CustomColor.morning)
    }
}
