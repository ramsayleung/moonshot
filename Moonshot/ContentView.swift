//
//  ContentView.swift
//  Moonshot
//
//  Created by ramsayleung on 2024-01-11.
//

import SwiftUI

struct CustomView: View {
    let text: String
    var body: some View {
        Text(text)
    }
    
    init(text: String) {
        print("Init custom \(text)")
        self.text = text
    }
}


struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State private var showingGrid = false
    @State private var showingFullMoom = false
    
    var body: some View {
        NavigationView {
            VStack{
                HStack {
                    Button {
                        showingFullMoom.toggle()
                    }
                    label: {
                        Text("Moonshot")
                            .font(.title.bold())
                            .foregroundStyle(.white)
                        Image(systemName: showingFullMoom ? "moonphase.full.moon" : "moon.fill")
                            .foregroundStyle(.white)
                            .animation(.easeIn(duration: 1), value: showingFullMoom)
                    }
                }
                if showingGrid {
                    GridLayout(astronauts: astronauts, missions: missions)
                } else {
                    ListLayout(astronauts: astronauts, missions: missions)
                }
            }
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .animation(.easeIn(duration: 2), value: showingGrid)
            .toolbar {
                Button {
                    showingGrid.toggle()
                } label: {
                    if showingGrid {
                        Image(systemName: "list.bullet")
                    } else{
                        Image(systemName: "square.grid.2x2")
                    }
                }.tint(.white)
            }
        }
    }
}

#Preview {
    ContentView()
}
