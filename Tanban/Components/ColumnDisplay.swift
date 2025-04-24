//
//  ColumnDisplay.swift
//  Tanban
//
//  Created by Luca on 24/04/2025.
//

import SwiftUI

struct ColumnDisplay: View {
    var column: Column
    @State private var selectedCard: Card? = nil

    init(column: Column) {
        self.column = column
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(column.title)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)

                ForEach(column.cards.sorted(by: { $0.position < $1.position })) { card in
                    cardView(for: card)
                }
            }
            .padding()
        }
    }

    private func cardView(for card: Card) -> some View {
        CardDisplay(card: card, isSelected: selectedCard == card)
            .padding(.bottom, 8)
            .onTapGesture {
                if selectedCard == card {
                    selectedCard = nil
                } else {
                    selectedCard = card
                }
            }
    }
}
