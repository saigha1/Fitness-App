//
//  FullScreenCoverWithDismissButton.swift
//  Fitness_App
//
//  Created by Xavier on 4/18/23.
//

import Foundation
import SwiftUI

extension View {
    //    @ViewBuilder func fullScreenCoverWithDismissButton<Root: View, Cover: View>(_ isPresented: <Binding>Bool, onDismiss)
    func fullScreenCoverWithDismissButton<Content>(
        alignment: Alignment = .topLeading,
        markColor: Color = .white,
        markSize: CGFloat = 15,
        buttonSize: CGFloat = 50,
        isPresented: Binding<Bool>,
        onDismiss: (() -> Void)? = nil, @ViewBuilder content: @escaping () -> Content
    ) -> some View where Content : View {
        return self
            .fullScreenCover(isPresented: isPresented, onDismiss: onDismiss) {
                ZStack(alignment: alignment) {
                    content().ignoresSafeArea()
                    Button {
                        isPresented.wrappedValue.toggle()
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: markSize, height: markSize, alignment: .center)
                            .foregroundColor(markColor)
                            .frame(width: buttonSize, height: buttonSize, alignment: .center)
                    }
                    
                    .padding(.leading, 15)
                }
            }
    }
}
#if DEBUG
import AVKit
struct FullScreenCoverWithDismissButtonView: View {
    @State private var showPlayer: Bool = false
    var player: some View {
        VStack {
            if let url = Bundle.main.url(forResource: "demo", withExtension: "mp4") {
                VideoPlayer(player: .init(url: url))
            } else if let url2 = URL(string: "https://bit.ly/swswift") {
                VideoPlayer(player: .init(url: url2))
            } else {
                Text("Invalid URL.")
            }
        }
    }
    var content: some View {
        VStack {
            Button {
                showPlayer.toggle()
            } label: {
                Text("Show Player")
            }
        }
        .navigationTitle("Test Player")
    }
    var body: some View {
        NavigationView {
            content.fullScreenCoverWithDismissButton(isPresented: $showPlayer) { player }
        }
    }
}
struct FullScreenCoverWithDismissButton_Previews: PreviewProvider {
    static var previews: some View {
        FullScreenCoverWithDismissButtonView()
    }
}
#endif
