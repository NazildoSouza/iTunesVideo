//
//  VideoView.swift
//  iTunesVideo
//
//  Created by Nazildo Souza on 20/05/20.
//  Copyright © 2020 Nazildo Souza. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct VideoView: View {
    @ObservedObject var videoData: VideoData
    @Environment(\.colorScheme) var colorScheme
    @State private var showPlayer1 = true
    @State private var showPlayer2 = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                Blur(style: .systemUltraThinMaterial).edgesIgnoringSafeArea(.all)
                
                if UIDevice.current.orientation.isLandscape {
                    Color.black.edgesIgnoringSafeArea(.all)
                        .navigationBarHidden(true)
                }
                
                if !UIDevice.current.orientation.isLandscape {
                    List {
                        VStack(alignment: .leading, spacing: 0) {
                            
                            HStack {
                                Spacer()
                                    .frame(height: UIDevice.current.userInterfaceIdiom == .pad ? geo.size.height / 2 - 50 : geo.size.height / 2)
                            }
                            
                            VStack(alignment: .leading) {
                                ForEach(self.videoData.videos, id: \.self) { video in
                                    Button(action: {
                                        self.videoData.videoUrl = video.previewUrl ?? "Desconhecido"
                                        self.videoData.videoTitle = video.trackName ?? "Desconhecido"
                                        self.videoData.imageUrl = video.artworkUrl100 ?? "Desconhecido"
                                        self.videoData.kind = video.kind ?? "Desconhecido"
                                        self.showPlayer1.toggle()
                                        self.showPlayer2.toggle()
                                    }) {
                                        HStack(alignment: .center) {
                                            WebImage(url: URL(string: video.artworkUrl100 ?? ""), options: .highPriority, context: nil)
                                                .renderingMode(.original)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 100, height: 100)
                                                .cornerRadius(15)
                                            
                                            VStack(alignment: .leading) {
                                                Text(video.trackName ?? "Desconhecido")
                                                    .font(.headline)
                                                    .lineLimit(2)

                                                Text(video.artistName ?? "Desconhecido")
                                                    .font(.headline)
                                                    .foregroundColor(.secondary)
                                                    .padding(.top, 4)
                                                    .lineLimit(2)

                                                Text(video.collectionName ?? "Desconhecido")
                                                    .font(.subheadline)
                                                    .foregroundColor(.secondary)
                                                    .lineLimit(2)
                                            }
                                            .padding(.leading)
                                        }
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            .padding(.vertical)
                        }
                    }
                    .edgesIgnoringSafeArea(.vertical)
                }
                
                VStack {

                    if !UIDevice.current.orientation.isLandscape {
                        HStack {
                            Spacer()
                            Text(self.videoData.videoTitle)
                                .font(.headline)
                                .fontWeight(.heavy)
                                .padding(.horizontal)
                                .multilineTextAlignment(.center)
                            Spacer(minLength: 0)
                            Button(action: {
                                withAnimation {
                                    self.videoData.showingVideoPlayer.toggle()
                                }
                                
                            }) {
                                Image(systemName: "xmark")
                                    .imageScale(.large)
                                    .padding(20)
                            }
                            
                        }
                        .frame(width: geo.size.width / 1.2)
                        .frame(height: 50)
                        .background(Blur(style: .systemChromeMaterial))
                        .cornerRadius(10)
                        .padding(.top, (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 20)
                        .shadow(color: Color.primary.opacity(0.3), radius: 4, x: 0, y: 0)
                    }
                    
                    if self.showPlayer1 {
                        ZStack {
                         //   Player(url: "https://youtu.be/F4sVvLtJVfo")
                            Player(url: self.videoData.videoUrl)
                                .frame(height: UIDevice.current.orientation.isLandscape ? geo.size.height : geo.size.height / 3)
                            
                            if self.videoData.kind == "song" {
                                WebImage(url: URL(string: self.videoData.imageUrl), options: .highPriority, context: nil)
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(15)
                                    .scaleEffect(UIDevice.current.orientation.isLandscape ? 2 : 1)
                            }
                        }
                    }
                    
                    if self.showPlayer2 {
                        ZStack {
                        //    Player(url: "https://youtu.be/F4sVvLtJVfo")
                            Player(url: self.videoData.videoUrl)
                                .frame(height: UIDevice.current.orientation.isLandscape ? geo.size.height : geo.size.height / 3)
                            
                            if self.videoData.kind == "song" {
                                WebImage(url: URL(string: self.videoData.imageUrl), options: .highPriority, context: nil)
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(15)
                                    .scaleEffect(UIDevice.current.orientation.isLandscape ? 2 : 1)
                            }
                        }
                    }
                        
                }
                .padding(.top, UIDevice.current.userInterfaceIdiom == .pad ? geo.size.height / 50 : geo.size.height / 50 - 10)
                .background(Blur(style: .systemMaterial).opacity(UIDevice.current.orientation.isLandscape ? 0 : 1))
                .edgesIgnoringSafeArea(.top)
            }
        }
    }
}
