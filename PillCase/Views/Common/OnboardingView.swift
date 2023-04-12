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
            OnboardingPage(imageName: "OScourses", color: CustomColor.day, title: NSLocalizedString("onboardingPage1-title", comment: ""), description: NSLocalizedString("onboardingPage1-description", comment: ""))
                .tag(0)
            OnboardingPage(imageName: "OSnewCourse", color: CustomColor.evening, title: NSLocalizedString("onboardingPage2-title", comment: ""), description: NSLocalizedString("onboardingPage2-description", comment: ""))
                .tag(1)
            OnboardingPage(imageName: "OScalendar", color: CustomColor.night, title: NSLocalizedString("onboardingPage3-title", comment: ""), description: NSLocalizedString("onboardingPage3-description", comment: ""))
                .tag(2)
            OnboardingPage(imageName: "OStoday", color: CustomColor.night, title: NSLocalizedString("onboardingPage4-title", comment: ""), description: NSLocalizedString("onboardingPage4-description", comment: ""))
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
                .padding(.leading, 20)
                .padding(.top, 20),
            alignment: .topLeading
            
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
        VStack(spacing: 5) {
            Image(imageName)
                .resizable()
                .minimumScaleFactor(0.5)
                .scaledToFit()
                .padding()
            
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .padding(5)
            Text(description)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.5)
                .lineLimit(3)
                .padding(5)
            Spacer()
        }
    }
}


