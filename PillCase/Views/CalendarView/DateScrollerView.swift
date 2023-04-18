//
//  DateScrollerView.swift
//  PillCase
//
//  Created by Максим Мосалёв on 06.03.2023.
//

import SwiftUI

struct DateScrollerView: View {
    @EnvironmentObject var dateHolder: DateHolder
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: previousMonth) {
                ZStack{
                    RoundedRectangle(cornerRadius: 23.scaled())
                        
                        .frame(width: 46.scaled(), height: 46.scaled())
                        .foregroundColor(CustomColor.backGroundColor)
                        .shadow(color: .black.opacity(0.2), radius: 3.scaled(), x:4.scaled(), y: 4.scaled())
                        .shadow(color: .white.opacity(0.8),  radius: 2.scaled(), x: -3.scaled(), y: -3.scaled())
                    Image(systemName: "arrow.left")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36.scaled(), height: 36.scaled())
                        .foregroundColor(CustomColor.navigationBarColor)
                }
            }
            ZStack {
                RoundedRectangle(cornerRadius: 16.scaled())
                
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(CustomColor.backGroundColor)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16.scaled(), style: .continuous)
                            .fill (
                                .shadow(.inner(color:.black.opacity(0.45),radius: 2.scaled(), x: 2.scaled(), y: 2.scaled()))
                                .shadow(.inner(color: .white.opacity(0.60), radius: 2.scaled(), x: -4.scaled(), y: -4.scaled()))
                            )
                            .foregroundColor(CustomColor.backGroundColor)
                            .clipShape(RoundedRectangle(cornerRadius: 16.scaled()))
                    }
                Text(CalendarHelper().monthYearString(dateHolder.date))
                    .font(.system(size: 28.scaled(), weight: .ultraLight, design: .monospaced))
                    .foregroundColor(.gray)
                    .animation(.none)
                    .frame(maxWidth: .infinity)
            }
            
            Button(action: nextMonth) {
                ZStack{
                    RoundedRectangle(cornerRadius: 23.scaled())
                        
                        .frame(width: 46.scaled(), height: 46.scaled())
                        .foregroundColor(CustomColor.backGroundColor)
                        .shadow(color: .black.opacity(0.2), radius: 3.scaled(), x:4.scaled(), y: 4.scaled())
                        .shadow(color: .white.opacity(0.8),  radius: 2.scaled(), x: -3.scaled(), y: -3.scaled())
                    Image(systemName: "arrow.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36.scaled(), height: 36.scaled())
                        .foregroundColor(CustomColor.navigationBarColor)
                }
            }
            Spacer()
        }
    }
    public func previousMonth()
     {
         dateHolder.date = CalendarHelper().minusMonth(dateHolder.date)
     }
     
     public func nextMonth()
     {
         dateHolder.date = CalendarHelper().plusMonth(dateHolder.date)
     }
  
}

struct DateScrollerView_Previews: PreviewProvider {
    static var previews: some View {
        DateScrollerView()
    }
}
