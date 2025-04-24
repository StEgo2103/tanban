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
                    Button(action: deleteSelectedKanban) {
                        Label("Delete Item", systemImage: "trash")
                    }
                    .disabled(selectedKanban == nil)
                }
            }
        } detail: {
            if let kanban = selectedKanban {
                HStack {
                    GeometryReader { geometry in
                        HStack(spacing: 6) {
                            ForEach(kanban.columns.sorted(by: { $0.position < $1.position })) { column in
                                VStack {
                                    ColumnDisplay(column: column)
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
        }
    }

    private func addKanban() {
        withAnimation {
            let newKanban = Kanban(title: "New Kanban", timestamp: Date())
            modelContext.insert(newKanban)
        }
    }

    private func deleteSelectedKanban() {
        if let kanban = selectedKanban {
            deleteItems(id: kanban.id)
            selectedKanban = nil
        }
    }

    private func deleteItems(id: UUID) {
        withAnimation {
            if let kanban = kanbans.first(where: { $0.id == id }) {
                modelContext.delete(kanban)
            }
        }
    }

    private func addCard(to column: Column) {
        withAnimation {
            let newCard = Card(title: "New Card", content: "", position: column.cards.last?.position ?? 0 + 1)
            modelContext.insert(newCard)
            column.cards.append(newCard)
        }
    }
}
