//
//  NewCourseView.swift
//  PillCase
//
//  Created by Максим Мосалёв on 02.02.2023.
//

import Combine
import SwiftUI

struct NewCourseView: View {
    @EnvironmentObject var mainViewModel: MainViewModel
    @ObservedObject var courseViewModel: CourseViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var name: String = ""
    
    
    let colors: [Color] = [CustomColor.firstCourse, CustomColor.secondCourse, CustomColor.thirdCourse, CustomColor.fourthCourse]
    @State var selectedColor: Color = CustomColor.thirdCourse
    
   
    
    let pillsType = ["Pill1", "Pill2", "Pill3", "Pill4", "RoundPill1", "RoundPill2", "RoundPill3", "RoundPill4", "RoundPillHalf1", "RoundPillHalf2", "Syringe", "Powder"]
    @State var selectedPillType = "Pill4"
    
    
    @State var dose: String = ""
    
    let units = ["г","мг", "мл", "МЕ"]
    @State var selectedUnit = "мг"
    
    
    @State var id = UUID()
    
    @State var morning = false
    @State var day = false
    @State var evening = false
    @State var night = false
    
    @State var numberOfIntakes = 0
    
   
    @State var selectedCourseDuration: Int = 14
    
    let regimen = ["каждый день", "через день", "раз в 3 дня", "раз в неделю"]
    @State var selectedRegimen = "каждый день"
    
    @State var startDate: Date = .now
    
    var isButtonActive: Bool {
           !name.isEmpty && !dose.isEmpty && (morning || day || evening || night)
       }
    
    var body: some View {
        NavigationStack {
            
            VStack{
                
                    Divider()
                    HStack (alignment: .center, spacing:5){
                        HStack{
                            TextField(text: $name) {
                                Text("Витамин Д")
                            }
                        }
                        
                        Divider()
                        
                        
                        HStack(spacing: 5){
                            
                            HStack(alignment: .center, spacing: 0){
                                
                                Picker("", selection: $selectedPillType) {
                                    ForEach(pillsType, id: \.self) {
                                        
                                        Image($0)
                                            .resizable()
                                            .frame(width: 35, height: 35)
                                            .scaleEffect(x: 5)
                                    }
                                    
                                }
                                
                                .pickerStyle(.wheel)
                                .labelsHidden()
                                
                                .scaleEffect(x: 0.2)
                                .frame(width: 80, height: 90)
                                .clipped()
                                .compositingGroup()
                                .colorMultiply(.black)
                               
                                
                            }
                            
                            
                            
                         // add picker from 4 colors here with wheel style
                            HStack(alignment: .center, spacing: 0) {
                                Picker("", selection: $selectedColor) {
                                    ForEach(colors, id: \.self) { color in
                                        color
                                            .frame(width: 30, height: 30)
                                            .cornerRadius(20)
                                            .scaleEffect(x: 5)
                                    }
                                }
                               
                               
                                .pickerStyle(.wheel)
                                .labelsHidden()
                                
                                .scaleEffect(x: 0.2)
                                .frame(width: 80, height: 90)
                                .clipped()
                                .compositingGroup()
                                
                            }
                            Spacer()
                        }
                
                        Divider()
                        
                        ZStack() {
                            Circle()
                                .frame(width: 42)
                                .foregroundColor(selectedColor)
                            Image(selectedPillType)
                                .resizable()
                                .frame(width: 32, height: 32)
                            
                        }
                        
                        
                    }
                    .padding([.leading, .trailing], 20)
                
                
                
            }
            .frame(maxHeight: 105)
            Form() {
               
                
                
                Section(header : Text("Дозировка")){
                    
                    VStack{
                        HStack {
                            TextField("250", text: $dose)
                                .keyboardType(.numberPad)
                                .onReceive(Just(dose)) { newValue in
                                    let filtered = newValue.filter { "0123456789".contains($0) }
                                    if filtered != newValue {
                                        dose = filtered
                                    }
                                }
                              
                             
                            
                            Picker("", selection: $selectedUnit) {
                                ForEach(units, id: \.self) {
                                    Text($0)
                                        .foregroundColor(.black)
                                }
                            }
                            .frame(width: 90, height: 20)
                            .pickerStyle(.menu)
                            
                            
                            
                            
                        }
                        
                    }
                }
                .tint(.black)
                Section(header: Text("Время приема")) {

                    Toggle(isOn: $morning) {
                        Text("Утро")
                    }
                    .tint(CustomColor.morning)

                    Toggle(isOn: $day) {
                        Text("День")
                    }
                    .tint(CustomColor.day)

                    Toggle(isOn: $evening) {
                        Text("Вечер")
                    }
                    .tint(CustomColor.evening)

                    Toggle(isOn: $night) {
                        Text("Ночь")
                    }
                    .tint(CustomColor.night)
                }
                
                
                
                Section(header: Text("Длительность курса и режим приема")) {
                    HStack{
                        Picker("Дней:", selection: $selectedCourseDuration) {
                            ForEach(1..<91) { number in
                                Text("\(number)")
                            }
                            
                        }
                       
                        
                        Picker("", selection: $selectedRegimen) {
                            ForEach(regimen, id: \.self) {
                                Text($0)
                                
                            }
                        }
                        
                    }
                    .pickerStyle(.menu)
                }
                .tint(.black)
                Section(header: Text("Дата начала курса")) {
                    HStack{
                        DatePicker("Первый день:", selection: $startDate, displayedComponents: [.date])
                            .datePickerStyle(.automatic)
                    }
                }
                HStack{
                    Spacer()
                    Button("Создать курс") {
                        DispatchQueue.main.async {
                            
                            
                            self.courseViewModel.createPillCourse(courseName: self.name, color: self.selectedColor, dose: self.dose, type: self.selectedPillType, unit: self.selectedUnit, startDate: self.startDate, selectedCourseDuration: self.selectedCourseDuration, selectedRegimen: self.selectedRegimen, id: self.id, morning: self.morning, day: self.day, evening: self.evening, night: self.night)
                            self.mainViewModel.creationReload()
                            self.presentationMode.wrappedValue.dismiss() // dismiss the view
                        }
                    }
                    .disabled(!isButtonActive)
                    
                    Spacer()
                }
            }
            .tint(selectedColor)
            .navigationBarTitle("Новый курс")
            .navigationBarTitleDisplayMode(.inline)
        }
//        .tint(selectedColor)
    }
}

struct NewCourseView_Previews: PreviewProvider {
    static var previews: some View {
        NewCourseView(courseViewModel: CourseViewModel(), startDate: .now)
            .environmentObject(CourseViewModel())
    }
}
