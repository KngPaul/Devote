//
//  CheckboxStyle.swift
//  Devote
//
//  Created by Paul Onawola on 25/06/2024.
//

import SwiftUI

struct CheckListStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(configuration.isOn ? .pink : .primary)
                .font(.system(size: 30, weight: .semibold, design: .rounded))
                .onTapGesture {
                    configuration.isOn.toggle()
                    feedback.notificationOccurred(.success)
                    
                    if configuration.isOn {
                        playSound(sound: "sound-rise", type: "mp3")
                    } else {
                        playSound(sound: "sound-tap", type: "mp3")
                    }
                }
            
            configuration.label
        }
    }
}

#Preview {
    Toggle("Placeholder Label", isOn: .constant(false))
        .toggleStyle(CheckListStyle())
        .padding()
}
