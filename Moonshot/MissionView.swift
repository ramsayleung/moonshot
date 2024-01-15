//
//  MissionView.swift
//  Moonshot
//
//  Created by ramsayleung on 2024-01-13.
//

import SwiftUI

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}

struct CrewGroupView: View {
    let crews: [CrewMember]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
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
}

struct DivdierView: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.lightBackground)
            .padding(.vertical)
    }
}

struct MissionView: View {
    
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
                HStack {
                    Text("Launch on: ")
                    Text(mission.displayLaunchedDate)
                        .foregroundColor(mission.displayLaunchedDate == "N/A" ? .gray : .white)
                }
                .padding()
                VStack(alignment: .leading){
                    DivdierView()
                    
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    
                    Text(mission.description)
                    
                    DivdierView()
                    
                    Text("Crew")
                        .font(.title.bold())
                    
                }
                .padding(.horizontal)

                CrewGroupView(crews: crews)
                
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
