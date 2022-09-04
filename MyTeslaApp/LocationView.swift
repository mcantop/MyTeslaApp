//
//  LocationView.swift
//  MyTeslaApp
//
//  Created by Maciej on 04/09/2022.
//

import SwiftUI
import MapKit

struct CarLocation: Identifiable {
    let id = UUID()
    let latitude: Double
    let longtitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
    }
}

let carLocations = [CarLocation(latitude: 40.7484, longtitude: -73.9857)]

struct LocationView: View {
    @Environment(\.dismiss) var dismiss
    @State private var location = MKCoordinateRegion(
        center: CLLocationCoordinate2DMake(40.7484, -73.9857),
        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    )
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $location, annotationItems: carLocations) { location in
                MapAnnotation(coordinate: location.coordinate, content: {
                    CarPin()
                })
            }
            
            VStack {
                Spacer()
                VStack(alignment: .leading, spacing: 20) {
                    CarLocationPanel()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color("DarkGray"))
                .foregroundColor(.white)
            }
            
            LinearGradient(gradient: Gradient(colors: [Color("DarkGray"), .clear, .clear]), startPoint: .top, endPoint: .bottom)
                .allowsHitTesting(false)
            VStack {
                HStack {
                    Button { dismiss() } label: {
                        GeneralButton(icon: "chevron.left")
                    }
                    
                    Spacer()
                    
                    Button { } label: {
                        GeneralButton(icon: "speaker.wave.3.fill")
                    }
                }
                .padding()
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("DarkGray"))
        .foregroundColor(.white)
        .navigationTitle("Mach Five")
        .navigationBarHidden(true)
    }
}

struct CarPin: View {
    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            Image(systemName: "car.fill")
                .frame(width: 36, height: 36, alignment: .center)
                .background(Color("Red"))
                .foregroundColor(.white)
                .clipShape(Circle())
            
            Text("March Five")
                .font(.footnote)
                .fontWeight(.medium)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(.black.opacity(0.1), lineWidth: 1))
        }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}

struct CarLocationPanel: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Location")
                .font(.title2)
                .fontWeight(.semibold)
            
            CustomDivider()
            
            Label("Address", systemImage: "location.fill")
                .font(.footnote)
                .foregroundColor(.gray)
        }
        
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 5) {
                Text("Summon")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Text("Press and hold controls to move vehicle")
                    .foregroundColor(.gray)
                    .font(.footnote)
            }
            
            CustomDivider()
            
            FullButton(text: "Go to Target")
            HStack {
                FullButton(text: "Forward", icon: "arrow.up")
                FullButton(text: "Backward", icon: "arrow.down")
            }
        }
    }
}
