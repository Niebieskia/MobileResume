//
//  SecondView.swift
//  ProjectTAC432
//
//  Created by Samantha Reap on 4/4/26.
//

import SwiftUI

struct PuzzumeView: View {
    @ObservedObject var store: ResumeStore
    
    var body : some View {
        VStack {
            Text("Drag to Reorganize")
                .font(.headline)
                .foregroundColor(.gray)
            
            List {
                //list to loop over items
                ForEach(store.items) { item in
                    PuzzleBubbleRow(item: item)
                        .padding(.vertical, 5)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                }
                .onMove(perform: move)
                .onDelete(perform: delete)
            }
            .listStyle(.plain)
            
            //I got the specific colors from figma
            .background(Color(red: 0.68, green: 0.82, blue: 0.94).opacity(0.3)) // Match home theme
            .toolbar { EditButton() }
        }
        .navigationTitle("Your Puzz-ume")
    }
    
    func move(from source: IndexSet, to destination: Int) {
        withAnimation {
            store.items.move(fromOffsets: source, toOffset: destination)
        }
    }
    
    func delete(at offsets: IndexSet){
        withAnimation {
            store.items.remove(atOffsets: offsets)
        }
    }
}

struct PuzzleBubbleRow: View {
    let item: ResumeItem //pass in data
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            Text(item.title)
                .font(.headline)
            Text(item.date)
                .font(.subheadline).foregroundColor(.secondary)
            Text(item.summary).font(.caption).italic()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color.blue.opacity(0.2), lineWidth: 1)
            )
        .shadow(radius: 2)
    }
}
