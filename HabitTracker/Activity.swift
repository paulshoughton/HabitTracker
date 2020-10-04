//
//  Activity.swift
//  HabitTracker
//
//  Created by Paul Houghton on 04/10/2020.
//

import Foundation

class Activity: ObservableObject, Identifiable, Codable {
    enum CodingKeys: CodingKey {
        case name, description, completionCount
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(completionCount, forKey: .completionCount)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        completionCount = try container.decode(Int.self, forKey: .completionCount)
    }
    
    var id = UUID()
    @Published var name: String
    @Published var description: String
    @Published var completionCount: Int = 0
    
    init(name: String, description: String) {
        self.name = name
        self.description = description
    }
    
    func completed() {
        self.completionCount += 1
    }
}

class Activities: ObservableObject {
    @Published var listOfActivities: [Activity] = [Activity]() {
        didSet {
            saveData()
        }
    }
    
    init() {
        if let listOfActivities = UserDefaults.standard.data(forKey: "listOfActivities") {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([Activity].self, from: listOfActivities) {
                self.listOfActivities = decoded
                return
            }
        }
        
        self.listOfActivities = []
    }
    
    func saveData() {
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(listOfActivities) {
            UserDefaults.standard.set(encoded, forKey: "listOfActivities")
        }
    }
    
}
