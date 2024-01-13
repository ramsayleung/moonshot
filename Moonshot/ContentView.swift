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
    
    let layout = [
        GridItem(.adaptive(minimum: 150)),
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: layout){
                    ForEach(missions){ mission in
                        NavigationLink {
                            Text("Detail")
                        } label: {
                            VStack {
                                Image(mission.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding()
                                
                                VStack {
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    
                                    Text(mission.displayLaunchedDate)
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.darkBackground)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground))
                        }
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    ContentView()
}
