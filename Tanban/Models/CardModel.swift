//
//  Item.swift
//  Tanban
//
//  Created by Luca on 21/04/2025.
//

import Foundation
import SwiftData

@Model
final class Card: Identifiable {
    var id: UUID
    var title: String
    var content: String
    var position: Int
    
    init(id: UUID = .init(), title: String, content: String = "", position: Int) {
        self.id = id
        self.title = title
        self.content = content
        self.position = position
    }
}
