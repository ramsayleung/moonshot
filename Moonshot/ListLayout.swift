//
//  ListLayout.swift
//  Moonshot
//
//  Created by ramsayleung on 2024-01-14.
//

import SwiftUI

struct ListLayout: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    var body: some View {
        NavigationView{
            List(missions){ mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    HStack {
                        Image(mission.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .padding()
                        
                        VStack {
                            Text(mission.displayName)
                                .font(.headline)
                                .foregroundStyle(.white)
                            
                            Text(mission.displayLaunchedDate)
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                    }
                }
                .listRowBackground(Color.darkBackground)
                .listRowSeparator(.visible)
            }
            .listStyle(.plain)
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
        .padding([.horizontal, .bottom])
    }
}


#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    return ListLayout(astronauts: astronauts, missions: missions)
}
