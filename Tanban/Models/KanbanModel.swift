//
//  Item.swift
//  Tanban
//
//  Created by Luca on 21/04/2025.
//

import Foundation
import SwiftData

@Model
final class Kanban: Identifiable {
    var id: UUID
    var title: String
    var timestamp: Date
    var columns: [Column]
    
    init(id: UUID = .init(), title: String, timestamp: Date, columns: [Column] = defaultColumns()) {
        self.id = id
        self.title = title
        self.timestamp = timestamp
        self.columns = columns
    }
}
