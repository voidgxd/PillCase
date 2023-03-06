//
//  DateScrollerView.swift
//  PillCase
//
//  Created by Максим Мосалёв on 06.03.2023.
//

import SwiftUI

struct DateScrollerView: View
{
    @EnvironmentObject var dateHolder: DateHolder
    
    var body: some View
    {
        HStack
        {
            Spacer()
            Button(action: previousMonth)
            {
                ZStack{
                    RoundedRectangle(cornerRadius: 23)
                        
                        .frame(width: 46, height: 46)
                        .foregroundColor(CustomColor.backGroundColor)
                        .shadow(color: .black.opacity(0.2), radius: 3, x:4, y: 4)
                        .shadow(color: .white.opacity(0.8),  radius: 2, x: -3, y: -3)
                    Image(systemName: "arrow.left")
                        .imageScale(.large)
                        .font(Font.title.weight(.bold))
                        .foregroundColor(CustomColor.morning)
                }
            }
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(CustomColor.backGroundColor)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill (
                                .shadow(.inner(color:.black.opacity(0.45),radius: 4, x: 4, y: 4))
                                .shadow(.inner(color: .white.opacity(0.60), radius: 2, x: -6, y: -6))
                            )
                            .foregroundColor(CustomColor.backGroundColor)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                Text(CalendarHelper().monthYearString(dateHolder.date))
                    .font(.title)
                    .bold()
                    .animation(.none)
                    .frame(maxWidth: .infinity)
            }
            Button(action: nextMonth)
            {
                ZStack{
                    RoundedRectangle(cornerRadius: 23)
                        
                        .frame(width: 46, height: 46)
                        .foregroundColor(CustomColor.backGroundColor)
                        .shadow(color: .black.opacity(0.2), radius: 3, x:4, y: 4)
                        .shadow(color: .white.opacity(0.8),  radius: 2, x: -3, y: -3)
                    Image(systemName: "arrow.right")
                        .imageScale(.large)
                        .font(Font.title.weight(.bold))
                        .foregroundColor(CustomColor.morning)
                }
            }
            Spacer()
        }
    }
    
    func previousMonth()
    {
        dateHolder.date = CalendarHelper().minusMonth(dateHolder.date)
    }
    
    func nextMonth()
    {
        dateHolder.date = CalendarHelper().plusMonth(dateHolder.date)
    }
}

struct DateScrollerView_Previews: PreviewProvider {
    static var previews: some View {
        DateScrollerView()
    }
}
