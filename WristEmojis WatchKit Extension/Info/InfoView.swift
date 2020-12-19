//
//  InfoView.swift
//  WristEmojis WatchKit Extension
//
//  Created by Michael Schoder on 19.12.20.
//

import SwiftUI

struct InfoView: View {
    @EnvironmentObject var provider: InfoViewProvider

    var body: some View {
        VStack(alignment: .leading) {
            Text("About WristEmojis".uppercased())
                .font(.headline)
                .foregroundColor(.accentColor)
                .frame(maxWidth: .infinity,alignment: .center)
                .padding([.top, .bottom], 4)

            Text("App Version")
            Text(provider.versionNumber)
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.bottom, 4)

            Text("Copyright")
            Text(provider.copyrightText)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
            .environmentObject(InfoViewProvider(dataProvider: PreviewDataProvider()))
    }
}
