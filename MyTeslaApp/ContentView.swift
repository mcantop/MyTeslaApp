//
//  ContentView.swift
//  MyTeslaApp
//
//  Created by Maciej on 03/09/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack(spacing: 20) {
                        HomeHeader()
                        CustomDivider()
                        CarSection()
                        CustomDivider()
                        CategoryView(title: "Quick Shortcuts", showEdit: true, actionItems: quickShortcuts)
                        CustomDivider()
                        CategoryView(title: "Recent Action", showEdit: false, actionItems: recentActions)
                        CustomDivider()
                        AllSettings()
                        ReorderButton()
                    }
                    .padding()
                    
                }
                VoiceCommandButton()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("DarkGray"))
            .foregroundColor(.white)
            .navigationTitle("Mach Five")
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct VoiceCommandButton: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Image(systemName: "mic.fill")
                    .font(.system(size: 24, weight: .semibold, design: .default))
                    .frame(width: 64, height: 64)
                    .background(Color("Green"))
                    .foregroundColor(Color("DarkGray"))
                    .clipShape(Circle())
                    .padding()
                    .shadow(radius: 10)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct HomeHeader: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("Model 3".uppercased())
                    .font(.caption2)
                    .fontWeight(.medium)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .foregroundColor(.white)
                    .background(Color("Red"))
                    .clipShape(Capsule())
                
                Text("Mach Five")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            }
            Spacer()
            HStack {
                Button { } label: {
                    GeneralButton(icon: "lock.fill")
                }
                
                Button { } label: {
                    GeneralButton(icon: "gear")
                }
            }
        }
        .padding(.top)
    }
}

struct CarSection: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                HStack {
                    Image(systemName: "battery.75")
                    Text("237 miles".uppercased())
                }
                .foregroundColor(Color("Green"))
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("Parked")
                        .fontWeight(.semibold)
                    
                    Text("Last updated: 5 min ago")
                        .font(.caption2)
                        .foregroundColor(.gray)
                    
                }
            }
            
            Image("Car")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

struct CategoryHeader: View {
    var title: String
    var showEdit: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Spacer()
                
                if showEdit {
                    Button { } label: {
                        Text("Edit")
                            .foregroundColor(.gray)
                            .fontWeight(.medium)
                    }
                }
            }
        }
    }
}


struct CategoryView: View {
    var title: String
    var showEdit: Bool
    
    var actionItems: [ActionItem]
    
    var body: some View {
        VStack {
            CategoryHeader(title: title, showEdit: showEdit)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top) {
                    ForEach(actionItems, id: \.self) { item in
                        ActionButton(item: item)
                    }
                }
            }
        }
    }
}

let quickShortcuts: [ActionItem] = [
    ActionItem(icon: "bolt.fill", text: "Charging"),
    ActionItem(icon: "fanblades.fill", text: "Fan On"),
    ActionItem(icon: "music.note", text: "Media Controls"),
    ActionItem(icon: "bolt.car", text: "Close Charge Port")
]

let recentActions: [ActionItem] = [
    ActionItem(icon: "arrow.up.square", text: "Open Trunk"),
    ActionItem(icon: "fanblades", text: "Fan Off"),
    ActionItem(icon: "person.fill.viewfinder", text: "Summon")
]

struct AllSettings: View {
    var body: some View {
        VStack {
            CategoryHeader(title: "All Settings")
            LazyVGrid(columns: [GridItem(.fixed(170)), GridItem(.fixed(170))]) {
                NavigationLink(destination: CarControlsView()) {
                    SettingBlock(icon: "car.fill", title: "Control", subtitle: "car locked")
                }
                SettingBlock(icon: "fanblades.fill", title: "Climate", subtitle: "Interior 68°F", backgroundColor: Color("Blue"))
                
                NavigationLink(destination: LocationView()) {
                    SettingBlock(icon: "location.fill", title: "Location", subtitle: "Empire State Building")
                }
                SettingBlock(icon: "checkerboard.shield", title: "Security", subtitle: "0 events detected")
                SettingBlock(icon: "sparkles", title: "Upgrades", subtitle: "3 upgrades available")
            }
        }
    }
}

struct SettingBlock: View {
    var icon: String
    var title: String
    var subtitle: String
    var backgroundColor: Color = .white.opacity(0.05)
    
    var body: some View {
        HStack(alignment: .center, spacing: 2) {
            Image(systemName: icon)
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 14, weight: .medium, design: .default))
                    .fontWeight(.semibold)
                
                Text(subtitle.uppercased())
                    .font(.system(size: 8, weight: .medium, design: .default))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(1)
            }
            .padding(.leading, 5)
            
            Spacer()
            
            Image(systemName: "chevron.right")
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 16)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(.white.opacity(0.1), lineWidth: 0.5))
    }
}

struct ReorderButton: View {
    var body: some View {
        Button {
            
        } label: {
            Text("Reorder Groups")
                .font(.caption)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(.white.opacity(0.05))
                .clipShape(Capsule())
        }
    }
}
