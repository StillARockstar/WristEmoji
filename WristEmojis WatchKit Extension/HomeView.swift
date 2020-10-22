//
//  ContentView.swift
//  WristEmojis WatchKit Extension
//
//  Created by Michael Schoder on 22.10.20.
//

import SwiftUI

struct HomeView: View {
    let data = ["🚀", "🦁", "🙈", "😉", "🐼", "💅", "😂", "🐹", "🐶", "🙂", "🐻", "🐨", "🦊", "😜"]

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(data, id: \.self) { item in
                    Button(action: {
                        print("hi")
                    }, label: {
                        Text(item)
                            .font(.title)
                    })
                    .aspectRatio(contentMode: .fill)
                }
            }
            Button("New Emoji") {
                print("hi")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
