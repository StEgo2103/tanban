//
//  CardDisplay.swift
//  Tanban
//
//  Created by Luca on 24/04/2025.
//

import SwiftUI

struct CardDisplay: View {
    @State private var isEditing = false
    @State private var editedTitle: String
    @State private var editedContent: String
    var isSelected: Bool

    var card: Card

    init(card: Card, isSelected: Bool = false) {
        self.card = card
        _editedTitle = State(initialValue: card.title)
        _editedContent = State(initialValue: card.content)
        self.isSelected = isSelected
    }

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                if isEditing {
                    TextField("Title", text: $editedTitle)
                        .font(.headline)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onSubmit {
                            toggleEdit()
                        }
                    TextField("Content", text: $editedContent)
                        .font(.body)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onSubmit {
                            toggleEdit()
                        }
                } else {
                    Text(card.title)
                        .font(.headline)
                        .padding(.bottom, 4)
                    Text(card.content)
                        .font(.body)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.gray.opacity(isSelected ? 0.8 : 0.2))
            .cornerRadius(8)
            .shadow(radius: 2)
        }
        .onTapGesture(count: 2) {
            toggleEdit()
        }
    }

    private func toggleEdit() {
        if isEditing {
            card.title = editedTitle
            card.content = editedContent
        }
        isEditing.toggle()
    }
}
