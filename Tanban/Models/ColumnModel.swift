import Foundation
import SwiftData
import SwiftUICore

@Model
final class Column: Identifiable {
    var id: UUID
    var title: String
    var position: Int
    var color: ColorRGB
    var cards: [Card]

    init(id: UUID = .init(), title: String, position: Int, color: ColorRGB = .init(), cards: [Card] = []) {
        self.id = id
        self.title = title
        self.position = position
        self.color = color
        self.cards = cards
    }
}

func defaultColumns() -> [Column] {
    return [
        Column(title: "To Do", position: 0, color: colorGray(), cards: [Card(title: "Test 1", content: "Text content", position: 0), Card(title: "Test 2", content: "Text content", position: 1), Card(title: "Test 3", content: "Text content", position: 2)]),
        Column(title: "In Progress", position: 1, color: colorBlue(), cards: [Card(title: "Test 1", content: "Text content", position: 0)]),
        Column(title: "Done", position: 2, color: colorGreen(), cards: [Card(title: "Test 1", content: "Text content", position: 0)])
    ]
}
