//
//  ListRowItemView.swift
//  Devote
//
//  Created by Paul Onawola on 25/06/2024.
//

import SwiftUI

struct ListRowItemView: View {
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var item: Item
    
    var body: some View {
        Toggle(isOn: $item.completion) {
            Text(item.task ?? "")
                .font(.system(.title2, design: .rounded))
                .fontWeight(.heavy)
                .foregroundStyle(item.completion ? .pink : .primary)
                .padding(.vertical, 12)
                .animation(.default.speed(0.25), value: item.completion)
        }
        .toggleStyle(.checklist)
        .onReceive(item.objectWillChange) { _ in
            if self.viewContext.hasChanges {
                try? self.viewContext.save()
            }
        }
    }
}
