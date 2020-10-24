//
//  ContentView.swift
//  WristEmojis WatchKit Extension
//
//  Created by Michael Schoder on 22.10.20.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var provider: HomeViewProvider
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(provider.entries, id: \.id) { item in
                    NavigationLink(
                        destination:
                            DetailView()
                            .environmentObject(DetailViewProvider(configuration: item, deleteable: true)),
                        label: {
                            Text(item.emoji)
                                .font(.title)
                        }
                    )
                    .aspectRatio(contentMode: .fill)
                }
            }
            NavigationLink(
                destination:
                    DetailView()
                    .environmentObject(DetailViewProvider(configuration: nil, deleteable: false)),
                label: {
                    Text("New Emoji")
                }
            )
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HomeViewProvider())
    }
}
