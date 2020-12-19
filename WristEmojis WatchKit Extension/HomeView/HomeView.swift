//
//  ContentView.swift
//  WristEmojis WatchKit Extension
//
//  Created by Michael Schoder on 22.10.20.
//

import SwiftUI

enum HomeViewSheetItemType: Identifiable {
    case info

    var id: Int { hashValue }
}

struct HomeView: View {
    @State var sheetItem: HomeViewSheetItemType?
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
                            .environmentObject(
                                DetailViewProvider(
                                    dataProvider: provider.dataProvider,
                                    configuration: item,
                                    deleteable: true
                                )
                            ),
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
                    .environmentObject(
                        DetailViewProvider(
                            dataProvider: provider.dataProvider,
                            configuration: nil,
                            deleteable: false
                        )
                    ),
                label: {
                    Text("New Emoji")
                }
            )
        }
        .onLongPressGesture {
            sheetItem = .info
        }
        .sheet(item: $sheetItem, content: { item -> AnyView in
            switch item {
            case .info:
                return InfoView()
                    .environmentObject(InfoViewProvider(dataProvider: provider.dataProvider))
                    .asAnyView()
            }
        })
        .navigationBarTitle("WristEmojis")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HomeViewProvider(dataProvider: PreviewDataProvider()))
    }
}
