//
//  Case.swift
//  PillCase
//
//  Created by Максим Мосалёв on 07.01.2023.
//

import SwiftUI

struct Case: View {
    var body: some View {
        VStack {
            
            HStack{
                
                VStack{
                    RoundPill(color: .red)
                }
                Spacer()
                VStack{
                    Button {
                        withAnimation {
                            
                        }
                    } label: {
                        RoundPill(color: .red)
                    }
                    .scaleEffect(1)
                    .animation(.linear(duration: 1), value: 1)
                }
            }
            HStack{
                VStack{
                    RoundPill(color: .orange)
                        
                }
                Spacer()
                VStack{
                    RoundPill(color: .teal)
                }
                
            }
     
            
        }
        .padding()
        .fixedSize(horizontal: false, vertical: false)
        
    }

}

struct Case_Previews: PreviewProvider {
    static var previews: some View {
        Case()
    }
}
