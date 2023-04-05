//
//  OnboardingPage.swift
//  PillCase
//
//  Created by Максим Мосалёв on 31.03.2023.
//

import SwiftUI

struct OnboardingPage: View {
    var imageName: String
    var color: Color
    var title: String
    var description: String

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

struct OnboardingPage_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPage(imageName: "OScourses", color: CustomColor.morning, title: "Add your medication courses", description: "Choose the duration of the course, the time of admission, the dose, etc.")
    }
}
