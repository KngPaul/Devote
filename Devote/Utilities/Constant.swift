//
//  Constant.swift
//  Devote
//
//  Created by Paul Onawola on 11/06/2024.
//

import SwiftUI


// MARK: - Formatter
let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

// MARK: - UI
var backgroundGradient: LinearGradient {
    LinearGradient(gradient: Gradient(colors: [.pink, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
}

// MARK: - UX
let feedback = UINotificationFeedbackGenerator()
