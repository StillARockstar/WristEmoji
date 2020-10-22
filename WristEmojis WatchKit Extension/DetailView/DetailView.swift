//
//  DetailView.swift
//  WristEmojis WatchKit Extension
//
//  Created by Michael Schoder on 22.10.20.
//

import SwiftUI

struct DetailView: View {
    @State var title: String = ""

    var body: some View {
        VStack() {
            Button(action: {

            }, label: {
                Text("🦁")
                    .font(.largeTitle)
            })
                .aspectRatio(1.0, contentMode: .fit)
            TextField("Name", text: $title)
            Spacer()
            Button("Save") {
                print("Save")
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
