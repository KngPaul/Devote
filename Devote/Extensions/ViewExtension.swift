//
//  KeyboardExtension.swift
//  Devote
//
//  Created by Paul Onawola on 11/06/2024.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    // MARK: - Keyboard
    // Function created to help hide the onscreen keyboard.
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
