//
//  DiaryEntry.swift
//  MemoMe
//
//  Created by Suldana Afrah on 8/11/25.
//

import Foundation

struct DiaryEntry: Codable {
    let id: String
    var content: String
    var date: Date
    var createdDate: Date
    
    init(content: String, date: Date) {
        self.id = UUID().uuidString
        self.content = content
        self.date = date
        self.createdDate = Date()
    }
}

// MARK: - DiaryEntry + UserDefaults
extension DiaryEntry {
    private static let entriesKey = "SavedDiaryEntries"
    
    // Save an array of diary entries to UserDefaults
    static func save(_ entries: [DiaryEntry]) {
        if let encoded = try? JSONEncoder().encode(entries) {
            UserDefaults.standard.set(encoded, forKey: entriesKey)
        }
    }
    
    // Retrieve all saved diary entries from UserDefaults
    static func getEntries() -> [DiaryEntry] {
        guard let data = UserDefaults.standard.data(forKey: entriesKey),
              let entries = try? JSONDecoder().decode([DiaryEntry].self, from: data) else {
            return []
        }
        return entries
    }
    
    // Save or update the current diary entry
    func save() {
        var entries = DiaryEntry.getEntries()
        
        // Check if entry already exists (update case)
        if let index = entries.firstIndex(where: { $0.id == self.id }) {
            entries[index] = self
        } else {
            // New entry
            entries.append(self)
        }
        
        DiaryEntry.save(entries)
    }
    
    // Get entries for a specific date
    static func getEntries(for date: Date) -> [DiaryEntry] {
        let allEntries = getEntries()
        return allEntries.filter { entry in
            Calendar.current.isDate(entry.date, inSameDayAs: date)
        }
    }
}
