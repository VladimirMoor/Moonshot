//
//  AstronautView.swift
//  Moonshot
//
//  Created by Vladimir on 01.06.2021.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let loadMissions: [Mission] = Bundle.main.decode("missions.json")
        
    var memberMissions: [Mission] {
        
        var matchedMissions = [Mission]()
        
        for mission in loadMissions {
            for crew in mission.crew {
                if crew.name == astronaut.id {
                    matchedMissions.append(mission)
                }
            }
        }
        
        return matchedMissions
        
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text(self.astronaut.description)
                        .padding()
                    
                    Text("Missions:")
                        .font(.title2)
                        
                    ForEach(self.memberMissions, id: \.id) { mission in
                        Text(mission.description)
                            .padding()
                            .foregroundColor(.blue)
                    }
                    
                    
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
