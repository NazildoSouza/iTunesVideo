//
//  ContentView.swift
//  iTunesVideo
//
//  Created by Nazildo Souza on 20/05/20.
//  Copyright © 2020 Nazildo Souza. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    @ObservedObject var videoData = VideoData()
    let endPoint = ["Todos", "Musica", "Video", "Filme", "Podcast"]
    
    init() {
        UITableView.appearance().showsVerticalScrollIndicator = false
    }
    
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            NavigationView {
                List {
                    ForEach(self.videoData.videos, id: \.self) { video in
                        Button(action: {
                            self.videoData.videoUrl = video.previewUrl ?? "Desconhecido"
                            self.videoData.videoTitle = video.trackName ?? "Desconhecido"
                            self.videoData.imageUrl = video.artworkUrl100 ?? "Desconhecido"
                            self.videoData.kind = video.kind ?? "Desconhecido"
                            self.videoData.showingVideoPlayer.toggle()
                        }) {
                            HStack(alignment: .top) {
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
                }
                .navigationBarTitle(Text("iTunes"))
            }
            
            VStack {
                SearchView(showBusca: self.$videoData.showingBusca, txt: self.$videoData.buscaArtist)
                    .padding(.vertical, 4)
                
                if self.videoData.showingBusca {
                    
                    Picker("Song Our Video", selection: self.$videoData.songOurVideoSelect) {
                        ForEach(0..<VideoData.endPoint.count, id: \.self) {
                            Text(self.endPoint[$0])
                        }
                    }
                    .background(Blur(style: .systemChromeMaterial))
                    .cornerRadius(6)
                    .padding(.horizontal)
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Button(action: {
                        if !self.videoData.videos.isEmpty {
                            self.videoData.videos.removeAll()
                        }
                        self.videoData.loadVideos()
                        self.videoData.buscaArtist = ""
                        withAnimation {
                            self.videoData.showingBusca = false
                        }
                        self.hiddenKeyboard()
                    }) {
                        Text("Buscar")
                            .padding(.horizontal)
                            .padding(.vertical, 10)
                            .background(Blur(style: .systemChromeMaterial))
                            .cornerRadius(15)
                            .padding([.top, .bottom])
                            .shadow(radius: 4)
                    }
                    .disabled(self.videoData.buscaArtist.isEmpty)
                }
            }
            .background(Blur(style: .systemMaterial).opacity(self.videoData.showingBusca ? 1 : 0))
            .cornerRadius(20)
            .offset(y: 90)
            .padding(.horizontal)
            
            if self.videoData.showingVideoPlayer {
                withAnimation {
                    VideoView(videoData: self.videoData)
                }
            }
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
      //  .onAppear(perform: self.videoData.loadInicio)
    }
    
    func hiddenKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SearchView: View {
    
    @Binding var showBusca: Bool
    @Binding var txt: String
    
    var body: some View {
        HStack {
            if self.showBusca {
                Image(systemName: "magnifyingglass")
                    .padding(10)
                TextField("Busca", text: self.$txt)
                
                Button(action: {
                    withAnimation {
                        self.showBusca.toggle()
                        self.txt = ""
                    }
                }) {
                    Image(systemName: "xmark")
                        .padding(10)
                    
                }
            } else {
                Button(action: {
                    withAnimation {
                        self.showBusca.toggle()
                    }
                    
                }) {
                    Image(systemName: "magnifyingglass")
                        .imageScale(.large)
                        .padding(20)
                }
            }
        }
        .padding(self.showBusca ? 10 : 0)
        .background(Blur(style: .systemChromeMaterial))
        .cornerRadius(25)
    }
    
}

