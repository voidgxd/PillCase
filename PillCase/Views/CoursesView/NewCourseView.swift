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
    
    let units = [
        NSLocalizedString("g", comment: ""),
        NSLocalizedString("mg", comment: ""),
        NSLocalizedString("mcg", comment: ""),
        NSLocalizedString("L", comment: ""),
        NSLocalizedString("ml", comment: ""),
        NSLocalizedString("oz", comment: ""),
        NSLocalizedString("IU", comment: ""),
        NSLocalizedString("tbsp", comment: ""),
        NSLocalizedString("tsp", comment: ""),
        NSLocalizedString("drop", comment: ""),
        NSLocalizedString("sprays", comment: ""),
        NSLocalizedString("pcs", comment: "")
    ]
    @State var selectedUnit = "mg"
    
    
    @State var id = UUID()
    
    @State var morning = false
    @State var day = false
    @State var evening = false
    @State var night = false
    
    @State var numberOfIntakes = 0
    
    @State var selectedCourseDuration: Int = 14
    
    let regimen = ["every day", "every other day", "every 3 days", "once a week"]
    @State var selectedRegimen = "every day"
    
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
                            Text("Vitamin D")
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
                Section(header : Text("Dose")){
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
                Section(header: Text("Medication time")) {
                    
                    Toggle(isOn: $morning) {
                        Text("Morning")
                    }
                    .tint(CustomColor.morning)
                    
                    Toggle(isOn: $day) {
                        Text("Day")
                    }
                    .tint(CustomColor.day)
                    
                    Toggle(isOn: $evening) {
                        Text("Evening")
                    }
                    .tint(CustomColor.evening)
                    
                    Toggle(isOn: $night) {
                        Text("Night")
                    }
                    .tint(CustomColor.night)
                }
                
                
                
                Section(header: Text("Course duration and medication regimen")) {
                    HStack{
                        Picker("Days:", selection: $selectedCourseDuration) {
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
                
                Section(header: Text("Course start date")) {
                    HStack{
                        DatePicker("First day:", selection: $startDate, displayedComponents: [.date])
                            .datePickerStyle(.automatic)
                    }
                }
                HStack{
                    Spacer()
                    Button("Create course") {
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
            .navigationBarTitle("New course")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct NewCourseView_Previews: PreviewProvider {
    static var previews: some View {
        NewCourseView(courseViewModel: CourseViewModel(), startDate: .now)
            .environmentObject(CourseViewModel())
    }
}
