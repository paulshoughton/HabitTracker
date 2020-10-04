//
//  ActivityView.swift
//  HabitTracker
//
//  Created by Paul Houghton on 04/10/2020.
//

import SwiftUI

struct ActivityView: View {
    @ObservedObject var activities: Activities
    @ObservedObject var activity: Activity
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Text("Completed \(activity.completionCount) time\(activity.completionCount == 1 ? "" : "s")")
            }
            .padding()
            HStack {
                 Text(activity.description)
                Spacer()
            }
            .padding()
                                    
            Spacer()
            
        }
        .navigationTitle(activity.name)
        .navigationBarItems(trailing: Button("Completed") {
            //Do Something
            activity.completed()
            activities.saveData()
        })
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView(
            activities: Activities(),
            activity: Activity(name: "Test Name", description: "Test Description"))
    }
}
