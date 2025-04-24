//
//  ContentView.swift
//  Tanban
//
//  Created by Luca on 21/04/2025.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var kanbans: [Kanban]
    @State private var selectedKanban: Kanban?
    @State private var selectedCard: Card?
    @State private var isEditingKanban = false
    @State private var editedKanbanTitle: String = ""

    @State private var showAlertConfimDelete: Bool = false

    init() {
        _kanbans = Query(sort: \.timestamp, order: .reverse)
    }

    var body: some View {
        NavigationSplitView {
            List(selection: $selectedKanban) {
                ForEach(kanbans) { kanban in
                    NavigationLink(value: kanban) {
                        Text(kanban.title)
                            .font(.headline)
                    }
                }
            }
            .navigationSplitViewColumnWidth(min: 220, ideal: 240)
            .toolbar {
                ToolbarItem {
                    Button(action: addKanban) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
                ToolbarItem {
                    Button(action: {
                        showAlertConfimDelete.toggle()
                    }) {
                        Label("Delete Item", systemImage: "trash")
                    }
                    .disabled(selectedKanban == nil)
                    .alert("Delete Kanban", isPresented: $showAlertConfimDelete, actions: {
                        Button("Delete", role: .destructive) {
                            deleteKanban()
                        }
                        Button("Cancel", role: .cancel) {}
                    }, message: {
                        Text("Are you sure you want to delete this kanban?")
                    })
                }
            }
        } detail: {
            if let kanban = selectedKanban {
                VStack {
                    HStack {
                        if isEditingKanban {
                            TextField("Kanban Title", text: $editedKanbanTitle)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .onSubmit {
                                    toggleEditKanban()
                                }
                        } else {
                            Text(kanban.title)
                                .font(.largeTitle)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .onTapGesture(count: 2, perform: toggleEditKanban)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)

                    HStack {
                        GeometryReader { geometry in
                            HStack(spacing: 6) {
                                ForEach(kanban.columns.sorted(by: { $0.position < $1.position })) { column in
                                    VStack {
                                        ColumnDisplay(column: column, selectedCard: $selectedCard)
                                    }
                                    .frame(width: geometry.size.width / CGFloat(kanban.columns.count) - 8, height: geometry.size.height - 12)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.clear)
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(column.color.color, lineWidth: 2)
                                    )
                                }
                            }
                            .padding(.top, 6)
                            .padding(.horizontal, 6)
                        }
                    }
                }
            } else {
                Text("Select an item or create one")
                    .font(.largeTitle)
                    .foregroundStyle(.secondary)
            }
        }.toolbar {
            ToolbarItem {
                if selectedKanban != nil {
                    Button(action: {
                        addCard(to: selectedKanban!.columns.first(where: { $0.title == "To Do" })!)
                    }) {
                        Label("New Card", systemImage: "plus.square")
                    }
                }
            }
            ToolbarItem {
                Button(action: deleteCard) {
                    Label("Delete Card", systemImage: "trash.square")
                }
                .disabled(selectedCard == nil)
            }
        }
    }

    private func toggleEditKanban() {
        if isEditingKanban {
            if let kanban = selectedKanban {
                kanban.title = editedKanbanTitle
            }
        } else {
            if let kanban = selectedKanban {
                editedKanbanTitle = kanban.title
            }
        }
        isEditingKanban.toggle()
    }

    private func addKanban() {
        withAnimation {
            let newKanban = Kanban(title: "New Kanban", timestamp: Date())
            modelContext.insert(newKanban)
        }
    }

    private func deleteKanban() {
        if let kanban = selectedKanban {
            withAnimation {
                if let kanban = kanbans.first(where: { $0.id == kanban.id }) {
                    modelContext.delete(kanban)
                }
            }
            selectedKanban = nil
        }
    }

    private func addCard(to column: Column) {
        withAnimation {
            let newCard = Card(title: "New Card", content: "", position: column.cards.last?.position ?? 0 + 1)
            modelContext.insert(newCard)
            column.cards.append(newCard)
        }
    }

    private func deleteCard() {
        if let card = selectedCard, let kanban = selectedKanban {
            withAnimation {
                if let column = kanban.columns.first(where: { $0.cards.contains(where: { $0.id == card.id }) }) {
                    modelContext.delete(card)
                    column.cards.removeAll(where: { $0.id == card.id })
                }
            }
            selectedCard = nil
        }
    }
}
