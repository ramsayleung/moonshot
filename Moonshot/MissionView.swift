//
//  MissionView.swift
//  Moonshot
//
//  Created by ramsayleung on 2024-01-13.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let crews: [CrewMember]
    let mission: Mission
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crews = mission.crew.map { member in
            if let astronaut = astronauts[member.name]{
                return CrewMember(role: member.role, astronaut: astronaut)
            }else {
                fatalError("Missing \(member.name)")
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Image(mission.imageName)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame([.horizontal]){width, axis in
                        width * 0.6
                    }
                VStack(alignment: .leading){
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.lightBackground)
                        .padding(.vertical)
                    
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    
                    Text(mission.description)
                    
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.lightBackground)
                        .padding(.vertical)
                    
                    Text("Crew")
                        .font(.title.bold())
                    
                }
                .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack {
                        ForEach(crews, id: \.role) { crew in
                            NavigationLink {
                                AstronautView(astronaut: crew.astronaut)
                            } label: {
                                HStack {
                                    Image(crew.astronaut.id)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width:  100, height: 72)
                                        .clipShape(Capsule())
                                        .overlay(Capsule()
                                            .strokeBorder(.white, lineWidth: 1))
                                    
                                    VStack(alignment: .leading) {
                                        Text(crew.astronaut.name)
                                            .font(.headline)
                                            .foregroundStyle(.white)
                                        
                                        Text(crew.role)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                }
                
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    return MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
