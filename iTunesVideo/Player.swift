//
//  Player.swift
//  iTunesVideo
//
//  Created by Nazildo Souza on 20/05/20.
//  Copyright © 2020 Nazildo Souza. All rights reserved.
//

import SwiftUI
import AVKit

struct Player: UIViewControllerRepresentable {
    var url: String
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let url2 = URL(string: url)!
        let player = AVPlayer(url: url2)
        let controler = AVPlayerViewController()
        controler.player = player
        controler.player?.play()
        return controler
    }
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
    }
}

struct Blur: UIViewRepresentable {
    let style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let effect = UIBlurEffect(style: style)
        let view = UIVisualEffectView(effect: effect)
        return view
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}
