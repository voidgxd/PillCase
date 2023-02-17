//
//  NewCourseView.swift
//  PillCase
//
//  Created by Максим Мосалёв on 02.02.2023.
//

import SwiftUI

struct NewCourseView: View {
    @ObservedObject var viewModel = NewCourseViewModel()
    @State var name: String = ""
    
    let colors: [Color] = [.blue, .green, .red, .yellow]
    @State var selectedColor: Color = .blue
    let pillsType = ["Pill1", "Pill2", "Pill3", "Pill4", "RoundPill1", "RoundPill2", "RoundPill3", "RoundPill4", "RoundPillHalf1", "RoundPillHalf2", "Syringe", "Powder"]
    @State var selectedPillType = "Pill1"
    
    
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
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section(header : Text("Название и вид")){
                    HStack (spacing:5){
                        HStack{
                            TextField(text: $name) {
                                Text("Витамин Д")
                            }
                        }
                        Divider()
                        HStack(){
                            
                            VStack(alignment: .trailing, spacing: 0){
                                
                                Picker("", selection: $selectedPillType) {
                                    ForEach(pillsType, id: \.self) {
                                        Image($0)
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                        
                                    }
                                    
                                }
                                .frame(width: 80, height: 60)
                                .pickerStyle(.wheel)
                                .colorMultiply(selectedColor)
                                
                                
                                
                            }
                            .frame(height: 35)
                            ColorPicker("", selection: $selectedColor)
                        }
                        
                    }
                }
                
                
                Section(header : Text("Дозировка")){
                    VStack{
                        HStack {
                            TextField(text: $dose) {
                                Text("250")
                            }
                            
                            Picker("", selection: $selectedUnit) {
                                ForEach(units, id: \.self) {
                                    Text($0)
                                    
                                }
                            }
                            .frame(width: 90, height: 20)
                            .pickerStyle(.menu)
                            
                            
                            
                        }
                        
                    }
                }
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
                Section(header: Text("Дата начала курса")) {
                    HStack{
                        DatePicker("Первый день:", selection: $startDate, displayedComponents: [.date])
                            .datePickerStyle(.automatic)
                        
                    }
                    
                }
                
                HStack{
                    Spacer()
                    Button("Создать курс") {
                        self.viewModel.createPillCourse(courseName: self.name, dose: self.dose, type: self.selectedPillType, unit: self.selectedUnit, startDate: self.startDate, selectedCourseDuration: self.selectedCourseDuration, selectedRegimen: self.selectedRegimen, id: self.id, morning: self.morning, day: self.day, evening: self.evening, night: self.night)
                        print("кнопка")
                        print(viewModel.pills)
                    }
                    Spacer()
                }
                
                
                
                
                
                
                
                
                
            }
            .navigationBarTitle("Новый курс")
            .navigationBarTitleDisplayMode(.inline)
        
        }
        .tint(selectedColor)
        
    }
}

struct NewCourseView_Previews: PreviewProvider {
    static var previews: some View {
        NewCourseView(startDate: .now)
    }
}
