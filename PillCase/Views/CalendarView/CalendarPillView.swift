//
//  CalendarPillView.swift
//  PillCase
//
//  Created by Максим Мосалёв on 06.03.2023.
//

import SwiftUI

struct CalendarPillView: View
{
    @EnvironmentObject var dateHolder: DateHolder
    
    var body: some View
    {
        NavigationStack {
            VStack(spacing: 1)
            {
                DateScrollerView()
                    .environmentObject(dateHolder)
                    .padding()
                    .frame(height: 84)

                dayOfWeekStack
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                    
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundColor(CustomColor.backGroundColor)
                    //                .shadow(color: .black.opacity(0.30), radius: 5, x: 9, y: 9)
                    //                .shadow(color: .white.opacity(1),  radius: 4, x: -9, y: -9)
                        .overlay {
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill (
                                    .shadow(.inner(color:.black.opacity(0.45),radius: 2, x: 2, y: 2))
                                    .shadow(.inner(color: .white.opacity(0.60), radius: 2, x: -6, y: -6))
                                )
                                .foregroundColor(CustomColor.backGroundColor)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                
                        }
                    
                    calendarGrid
                        .padding(.horizontal, 4)
                        .padding(.vertical, 4)
                }
                .padding(.horizontal, 1)
                Divider()
            }
            .background(CustomColor.backGroundColor)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(CustomColor.morning, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        
                    } label: {
                        Image(systemName: "list.bullet").foregroundColor(.white
                        )
                        .font(.system(size: 22, weight: .bold))
                    }
                    
                    
                }
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("PillCase")
                            .bold()
                            .foregroundColor(.white)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    Button {
                        
                    } label: {
                        
                            Image(systemName: "pills.circle").foregroundColor(.white
                            )
                            .font(.system(size: 22, weight: .bold))
                        }
                    
                        
                                    }
                    
                }
        }
        
    }
    var dayOfWeekStack: some View
    {
        HStack(spacing: 1)
        {
            Text("Sun").dayOfWeek()
            Text("Mon").dayOfWeek()
            Text("Tue").dayOfWeek()
            Text("Wed").dayOfWeek()
            Text("Thu").dayOfWeek()
            Text("Fri").dayOfWeek()
            Text("Sat").dayOfWeek()
        }
    }
    
    var calendarGrid: some View
    {
        VStack(spacing: 1)
        {
            let daysInMonth = CalendarHelper().daysInMonth(dateHolder.date)
            let firstDayOfMonth = CalendarHelper().firstOfMonth(dateHolder.date)
            let startingSpaces = CalendarHelper().weekDay(firstDayOfMonth)
            let prevMonth = CalendarHelper().minusMonth(dateHolder.date)
            let daysInPrevMonth = CalendarHelper().daysInMonth(prevMonth)
            
            ForEach(0..<6)
            {
                row in
                
                    HStack(spacing: 1)
                    {
                        
                       
                        
                        ForEach(1..<8)
                        {
                            column in
                            let count = column + (row * 7)
                            
                            CalendarCell(count: count, startingSpaces:startingSpaces, daysInMonth: daysInMonth, daysInPrevMonth: daysInPrevMonth)
                                .environmentObject(dateHolder)
                            
                        }
                        
                    }
                
            }
        }
        .frame(maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarPillView()
    }
}


extension Text
{
    func dayOfWeek() -> some View
    {
        self.frame(maxWidth: .infinity)
            .padding(.top, 1)
            .lineLimit(1)
    }
}
