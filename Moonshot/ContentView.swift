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
                    
                    GeometryReader { geo in
                    Image(mission.image)
                        .resizable()
                        .scaleEffect(1 + geo.frame(in: .global).maxY / 1000)
                        .frame(width: 44, height: 44)
                        .accessibility(removeTraits: .isImage)
                    }
                    .frame(width: 60)
                    .padding(.top, 20)
                        
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
