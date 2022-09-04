//
//  CarControlsView.swift
//  MyTeslaApp
//
//  Created by Maciej on 04/09/2022.
//

import SwiftUI

let carControls: [ActionItem] = [
    ActionItem(icon: "flashlight.on.fill", text: "Flash"),
    ActionItem(icon: "speaker.wave.3.fill", text: "Honk"),
    ActionItem(icon: "key.fill", text: "Start"),
    ActionItem(icon: "arrow.up.bin", text: "Front Trunk"),
    ActionItem(icon: "arrow.up.square", text: "Trunk")
]

struct CarControlsView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var toggleValet = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            GeneralButton(icon: "chevron.left")
                        }

                        Spacer()
                    }
                    Text("Car Controls")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                CustomDivider()
                CarLockButton()
                CustomDivider()
                CarControlActions()
                CustomDivider()
                HStack {
                    Toggle(isOn: $toggleValet) {
                        Text("Valet Mode")
                            .fontWeight(.medium)
                    }
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("DarkGray"))
        .foregroundColor(.white)
        .navigationTitle("Mach Five")
        .navigationBarHidden(true)
    }
}

struct CarControlsView_Previews: PreviewProvider {
    static var previews: some View {
        CarControlsView()
    }
}

struct CarLockButton: View {
    var body: some View {
        Button {
        
        } label: {
            FullButton(text: "Unlock Car", icon: "lock.fill")
        }
    }
}

struct CarControlActions: View {
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Spacer()
                ActionButton(item: carControls[0])
                Spacer()
                ActionButton(item: carControls[1])
                Spacer()
                ActionButton(item: carControls[2])
                Spacer()
            }
            
            HStack {
                Spacer()
                ActionButton(item: carControls[3])
                Spacer()
                ActionButton(item: carControls[4])
                Spacer()
            }
        }
        .padding()
    }
}
