//
//  AddActivity.swift
//  HabitTracker
//
//  Created by Paul Houghton on 04/10/2020.
//

import SwiftUI

struct AddActivity: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var activities: Activities
    @State private var name: String = ""
    @State private var description: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                TextField("Description", text: $description)
            }
            .navigationBarTitle("Add Activity")
            .navigationBarItems(trailing: Button("Save") {
                let newActivity = Activity(name: name, description: description)
                self.activities.listOfActivities.append(newActivity)
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct AddActivity_Previews: PreviewProvider {
    static var previews: some View {
        AddActivity(activities: Activities())
    }
}
