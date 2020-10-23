//
//  DetailView.swift
//  WristEmojis WatchKit Extension
//
//  Created by Michael Schoder on 22.10.20.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var provider: DetailViewProvider

    var body: some View {
        VStack() {
            Button(action: {

            }, label: {
                Text(provider.emoji)
                    .font(.largeTitle)
            })
                .aspectRatio(1.0, contentMode: .fit)
            TextField("Name", text: $provider.name)
            Spacer()
            HStack {
                Button("Save") {
                    print("Save")
                }
                if provider.deleteable {
                    Button("Delete") {
                        print("Delete")
                    }
                        .foregroundColor(.red)
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
            .environmentObject(DetailViewProvider(
                                configuration: EmojiConfiguration(id: "", emoji: "🚀", name: "Rocket"),
                                deleteable: true)
            )
        DetailView()
            .environmentObject(DetailViewProvider(
                                configuration: EmojiConfiguration(id: "", emoji: "🚀", name: "Rocket"),
                                deleteable: false)
            )
    }
}
