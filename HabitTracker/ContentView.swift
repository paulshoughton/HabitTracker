//
//  ContentView.swift
//  HabitTracker
//
//  Created by Paul Houghton on 04/10/2020.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var activities = Activities()
    @State private var showingAddActivity = false
    
    var body: some View {

        NavigationView {
            List(activities.listOfActivities) { activity in
                NavigationLink(
                    destination:
                        ActivityView(activities: activities, activity: activity)
                ) {
                    Text(activity.name)
                }
            }
            .navigationBarTitle("HabitTracker")
            .navigationBarItems(trailing: Button("Add") {
                self.showingAddActivity = true
            } )
        }
        .sheet(isPresented: $showingAddActivity) {
            AddActivity(activities: self.activities)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
