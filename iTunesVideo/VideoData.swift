//
//  VideoData.swift
//  iTunesVideo
//
//  Created by Nazildo Souza on 20/05/20.
//  Copyright © 2020 Nazildo Souza. All rights reserved.
//

import SwiftUI

class VideoData: ObservableObject {
    @Published var videos = [Result]()
    @Published var showingVideoPlayer = false
    @Published var showingBusca = false
    @Published var buscaArtist = ""
    @Published var songOurVideoSelect = 0
    @Published var videoUrl = ""
    @Published var videoTitle = ""
    @Published var imageUrl = ""
    @Published var kind = ""
    @State private var amgArtistId = [485351, 1048165, 435023, 2961317, 3128346]
    @State private var artistId = [4211656, 503554352, 290231550, 471744, 1080488211, 589477027, 723844870]
    static let endPoint = ["", "&entity=song", "&entity=musicVideo", "&entity=movie", "&entity=podcast"]
    
    init() { loadInicio() }
    
    func loadVideos() {
        let endPoint = "https://itunes.apple.com/search?term=\(buscaArtist.lowercased().replacingOccurrences(of: " ", with: "+"))\(Self.endPoint[songOurVideoSelect])&country=br&limit=200"

        guard let url = URL(string: endPoint) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            
            do {
                let json = try JSONDecoder().decode(Videos.self, from: data)
                
                DispatchQueue.main.async {
                    self.videos = json.results
                    print(json.resultCount)
                }
                
            } catch {
                print(error.localizedDescription)
                print(error)
            }
        }.resume()
    }
    
    func loadInicio() {
        let endPoint = "https://itunes.apple.com/lookup?amgArtistId=\(amgArtistId[Int.random(in: 0..<5)])&entity=song&limit=20&sort=recent"
      //  let endPoint = "https://itunes.apple.com/lookup?id=\(artistId[0])"
        guard let url = URL(string: endPoint) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            
            do {
                let json = try JSONDecoder().decode(Videos.self, from: data)
                
                DispatchQueue.main.async {
                    self.videos = json.results
                    print(json.resultCount)
                }
                
            } catch {
                print(error.localizedDescription)
                print(error)
            }
        }.resume()
    }
}
