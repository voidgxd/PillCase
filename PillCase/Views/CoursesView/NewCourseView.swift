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
    
    let pillsType = ["Pill1", "Pill2", "Pill3", "Pill4", "RoundPill1", "RoundPill2", "RoundPill3", "RoundPill4", "RoundPillHalf1", "RoundPillHalf2", "Syringe", "Powder", "Spray", "Drop"]
    @State var selectedPillType = "Pill4"
    
    @State var dose: String = ""
    
    let units = [
        DoseUnits.g,
        DoseUnits.mg,
        DoseUnits.mcg,
        DoseUnits.L,
        DoseUnits.ml,
        DoseUnits.oz,
        DoseUnits.IU,
        DoseUnits.tbsp,
        DoseUnits.tsp,
        DoseUnits.drops,
        DoseUnits.sprays,
        DoseUnits.pcs,
    ]
    @State var selectedUnit = DoseUnits.mg
    
    
    @State var id = UUID()
    
    @State var morning = false
    @State var day = false
    @State var evening = false
    @State var night = false
    
    @State var numberOfIntakes = 0
    
    @State var selectedCourseDuration: Int = 14
    
//    let regimen = [
//        NSLocalizedString("every day", comment: ""),
//        NSLocalizedString("every other day", comment: ""),
//        NSLocalizedString("every 3 days", comment: ""),
//        NSLocalizedString("once a week", comment: ""),
//        NSLocalizedString("every day", comment: "")
//        ]
//    @State var selectedRegimen = "every day"
    
    let regimen = [
        RegimenOption.everyDay,
        RegimenOption.everyOtherDay,
        RegimenOption.everyThreeDays,
        RegimenOption.onceAWeek
    ]
    @State var selectedRegimen = RegimenOption.everyDay
    
    @State var startDate: Date = .now
    
    @State private var showingUniqeNameAlert = false
    
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
                        .onTapGesture {
                            self.hideKeyboard()
                        }
                        
                                    
                    }
                   
                    Divider()
                    HStack(spacing: 5.scaled()){
                        HStack(alignment: .center, spacing: 0){
                            
                            Picker("", selection: $selectedPillType) {
                                ForEach(pillsType, id: \.self) {
                                    
                                    Image($0)
                                        .resizable()
                                        .frame(width: 35.scaled(), height: 35.scaled())
                                        .scaleEffect(x: 2)
                                        
                                }
                            }
                            .pickerStyle(.wheel)
                            .labelsHidden()
                            .scaleEffect(x: 0.5)
                            .frame(width: 80.scaled(), height: 90.scaled())
                            .clipped()
                            .compositingGroup()
                            .colorMultiply(.black)
                        }
                        // add picker from 4 colors here with wheel style
                        HStack(alignment: .center, spacing: 0) {
                            Picker("", selection: $selectedColor) {
                                ForEach(colors, id: \.self) { color in
                                    color
                                        .frame(width: 30.scaled(), height: 30.scaled())
                                        .cornerRadius(20.scaled())
                                        .scaleEffect(x: 2)
                                }
                            }
                            .pickerStyle(.wheel)
                            .labelsHidden()
                            
                            .scaleEffect(x: 0.5)
                            .frame(width: 80.scaled(), height: 90.scaled())
                            .clipped()
                            .compositingGroup()
                        }
                        Spacer()
                    }
                    Divider()
                    ZStack() {
                        Circle()
                            .frame(width: 42.scaled())
                            .foregroundColor(selectedColor)
                        Image(selectedPillType)
                            .resizable()
                            .frame(width: 32.scaled(), height: 32.scaled())
                    }
                }
                .padding([.leading, .trailing], 20.scaled())
            }
            .frame(maxHeight: 105.scaled())
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
                                .onTapGesture {
                                    self.hideKeyboard()
                                }
                            
                            Picker(selection: $selectedUnit, label: Text("")) {
                                ForEach(units, id: \.self) { option in
                                    Text(NSLocalizedString(option.rawValue, comment: ""))
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
//                        Picker("", selection: $selectedRegimen) {
//                            ForEach(regimen, id: \.self) {
//                                Text($0)
//                            }
//                        }
                        Picker(selection: $selectedRegimen, label: Text("")) {
                            ForEach(regimen, id: \.self) { option in
                                Text(NSLocalizedString(option.rawValue, comment: ""))
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
                        if courseViewModel.isCourseNameUnique(name) {
                        DispatchQueue.main.async {
                            self.courseViewModel.createPillCourse(courseName: self.name, color: self.selectedColor, dose: self.dose, type: self.selectedPillType, unit: self.selectedUnit.rawValue, startDate: self.startDate, selectedCourseDuration: self.selectedCourseDuration, selectedRegimen: self.selectedRegimen, id: self.id, morning: self.morning, day: self.day, evening: self.evening, night: self.night)
                            self.mainViewModel.creationReload()
                            self.presentationMode.wrappedValue.dismiss() // dismiss the view
                        }
                        } else {
                            self.showingUniqeNameAlert = true
                        }
                    }
                    .disabled(!isButtonActive)
                    .alert(isPresented: $showingUniqeNameAlert) {
                        Alert(title: Text("A course with the same name already exists"), message: Text("Please enter a different course name."), dismissButton: .default(Text("OK")))
                    }
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
