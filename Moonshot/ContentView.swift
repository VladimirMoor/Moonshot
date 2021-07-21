//
//  ContentView.swift
//  Moonshot
//
//  Created by Vladimir on 01.06.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isToggle = false
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
       
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                        .accessibility(removeTraits: .isImage)
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                        .font(.headline)
                        
                        if isToggle {
                        Text(mission.formattedLaunchDate)
                        } else {
                            ForEach(0..<mission.crew.count) { num in
                                Text("\(mission.crew[num].name)")
                            }
                        }
                    }
                }
                .accessibility(addTraits: .isButton)
            }
            .navigationTitle("Moonshot")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("press") {
                        isToggle.toggle()
                    }
                    }
                }

        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}
}
