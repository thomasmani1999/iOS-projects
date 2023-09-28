//
//  ListRowItemView.swift
//  devote
//
//  Created by Thomas Mani on 25/09/23.
//

import SwiftUI

struct ListRowItemView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var item: Item
    
    var body: some View {
        Toggle(isOn: $item.completion) {
            Text(item.task ?? "")
                .font(.system(.title2,design: .rounded))
                .fontWeight(.heavy)
                .foregroundColor( item.completion ? .pink : .primary)
                .padding(.vertical)
                .animation(.default, value: item.completion)
        }
        .toggleStyle(CheckboxStyle())
        .onReceive(item.objectWillChange) { _ in
            if self.viewContext.hasChanges{
                try? self.viewContext.save()
            }
        }
    }
}

