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
        switch provider.mode {
        case .create:
            return AnyView(createDetailView)
        case .view:
            return AnyView(viewDetailView)
        }
    }

    private var createDetailView: some View {
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
            TextField(LocalizedStringKey("detail.name"), text: $provider.name)
            Button("detail.save") {
                presentationMode.wrappedValue.dismiss()
                provider.save()
            }
        }
    }

    private var viewDetailView: some View {
        VStack() {
            Text(provider.emoji)
                .font(.largeTitle)
                .padding(.all, 10)
            HStack() {
                Text(provider.name)
                    .padding(.leading, 10)
                    .padding([.top, .bottom], 12)
                Spacer()
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            Button("detail.delete.button") {
                showingDeleteAlert = true
            }
            .foregroundColor(.red)
            .alert(isPresented: $showingDeleteAlert, content: {
                Alert(
                    title: Text("detail.delete.title"),
                    message: nil,
                    primaryButton: .destructive(
                        Text("detail.delete.confirm"),
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

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
            .environmentObject(
                DetailViewProvider(
                    dataProvider: PreviewDataProvider(),
                    configuration: EmojiConfiguration(id: "", emoji: "🚀", name: "Rocket"),
                    mode: .create
                )
            )
        DetailView()
            .environmentObject(
                DetailViewProvider(
                    dataProvider: PreviewDataProvider(),
                    configuration: EmojiConfiguration(id: "", emoji: "🚀", name: "Rocket"),
                    mode: .view
                )
            )
    }
}
