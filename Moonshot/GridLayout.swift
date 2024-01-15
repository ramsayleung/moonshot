//
//  GridLayout.swift
//  Moonshot
//
//  Created by ramsayleung on 2024-01-14.
//

import SwiftUI

struct GridLayout: View {
    let layout = [
        GridItem(.adaptive(minimum: 150)),
    ]
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: layout){
                    ForEach(missions){ mission in
                        NavigationLink {
                            MissionView(mission: mission, astronauts: astronauts)
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
            }
            .padding([.horizontal, .bottom])
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    return GridLayout(astronauts: astronauts, missions: missions)
}
