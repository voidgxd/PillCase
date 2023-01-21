//
//  PillView.swift
//  PillCase
//
//  Created by Максим Мосалёв on 21.01.2023.
//

import SwiftUI

struct PillView: View {
    var body: some View {
        Image("Frame1")
            .resizable()
                .frame(width: 32.0, height: 32.0)
    }
        
}

struct PillView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.black)
            PillView()
        }
    }
}
