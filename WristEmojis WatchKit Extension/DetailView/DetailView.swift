//
//  DetailView.swift
//  WristEmojis WatchKit Extension
//
//  Created by Michael Schoder on 22.10.20.
//

import SwiftUI

struct DetailView: View {
    @State private var showingEmojiPicker = false
    @State private var showingDeleteAlert = false
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var provider: DetailViewProvider

    var body: some View {
        VStack() {
            Button(action: {
                showingEmojiPicker = true
            }, label: {
                Text(provider.emoji)
                    .font(.largeTitle)
            })
            .sheet(isPresented: $showingEmojiPicker, content: {
                EmojiPicker { emoji in
                    provider.emoji = emoji
                }
            })
            .aspectRatio(1.0, contentMode: .fit)
            TextField("Name", text: $provider.name)
            Spacer()
            HStack {
                Button("Save") {
                    presentationMode.wrappedValue.dismiss()
                    provider.save()
                }
                if provider.deleteable {
                    Button("Delete") {
                        showingDeleteAlert = true
                    }
                    .foregroundColor(.red)
                    .alert(isPresented: $showingDeleteAlert, content: {
                        Alert(
                            title: Text("Delete this entry?"),
                            message: nil,
                            primaryButton: .destructive(
                                Text("Delete"),
                                action: {
                                    presentationMode.wrappedValue.dismiss()
                                    provider.delete()
                                }
                            ),
                            secondaryButton: .cancel()
                        )
                    })
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
            .environmentObject(
                DetailViewProvider(
                    dataProvider: PreviewDataProvider(),
                    configuration: EmojiConfiguration(id: "", emoji: "🚀", name: "Rocket"),
                    deleteable: true
                )
            )
        DetailView()
            .environmentObject(
                DetailViewProvider(
                    dataProvider: PreviewDataProvider(),
                    configuration: EmojiConfiguration(id: "", emoji: "🚀", name: "Rocket"),
                    deleteable: false
                )
            )
    }
}
