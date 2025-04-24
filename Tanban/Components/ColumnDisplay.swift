//
//  ColumnDisplay.swift
//  Tanban
//
//  Created by Luca on 24/04/2025.
//

import SwiftUI

struct ColumnDisplay: View {
    var column: Column
    @Binding var selectedCard: Card?

    init(column: Column, selectedCard: Binding<Card?>) {
        self.column = column
        _selectedCard = selectedCard
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(column.title)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)

                ForEach(column.cards.sorted(by: { $0.position < $1.position })) { card in
                    CardDisplay(card: card, isSelected: $selectedCard)
                        .padding(.bottom, 8)
                }
            }
            .padding()
        }
    }
}
