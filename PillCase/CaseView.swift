//
//  Case.swift
//  PillCase
//
//  Created by Максим Мосалёв on 07.01.2023.
//

import SwiftUI

struct CaseView: View {
    var body: some View {
        VStack {
            Spacer()
            ScrollCurseView()
            Spacer()
            VStack {
                VStack (spacing: 0) {
                    HStack (spacing: 0) {
                        
                        SegmentView(color: CustomColor.morning, secondColor: CustomColor.morningSecond, shadowColor: CustomColor.morningShadow, degrees: 0, letter: "M", isEmpty: false)
                        
                        SegmentView(color: CustomColor.day, secondColor: CustomColor.daySecond, shadowColor: CustomColor.dayShadow, degrees: 90, letter: "D", isEmpty: true)
                        
                        
                        
                    }
                    HStack (spacing: 0) {
                        SegmentView(color: CustomColor.night, secondColor: CustomColor.nightSecond, shadowColor: CustomColor.nightShadow, degrees: -90, letter: "N", isEmpty: true)
                        SegmentView(color: CustomColor.evening, secondColor: CustomColor.eveningSecond, shadowColor: CustomColor.eveningShadow, degrees: 180, letter: "E", isEmpty: false)
                    }
                }
            }
            .padding()
            .fixedSize(horizontal: false, vertical: false)
            Spacer()
        }
    }

}

struct Case_Previews: PreviewProvider {
    static var previews: some View {
        CaseView()
    }
}
