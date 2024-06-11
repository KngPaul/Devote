//
//  Modifier.swift
//  Devote
//
//  Created by Paul Onawola on 11/06/2024.
//

import SwiftUI

struct ClearListModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16, *) {
            content
                .scrollContentBackground(.hidden)
        } else {
            content
                .onAppear {
                    UITableView.appearance().backgroundColor = UIColor.clear
                }
        }
        
    }
}

#Preview {
    Text("Hello, world!")
        .modifier(ClearListModifier())
}
