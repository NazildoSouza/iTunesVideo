//
//  Video.swift
//  iTunesVideo
//
//  Created by Nazildo Souza on 20/05/20.
//  Copyright © 2020 Nazildo Souza. All rights reserved.
//

import SwiftUI

// MARK: - Videos
struct Videos: Codable, Hashable {
    let resultCount: Int
    let results: [Result]
}

// MARK: - Result
struct Result: Codable, Hashable {
    let wrapperType: String?
    let kind: String?
    let artistType: String?
    let artistLinkUrl: String?
    let artistId: Int?
    let amgArtistId: Int?
    let primaryGenreId: Int?
    let collectionId: Int?
    let trackId: Int?
    let artistName: String?
    let collectionName: String?
    let trackName: String?
    let collectionCensoredName: String?
    let trackCensoredName: String?
    let artistViewUrl: String?
    let collectionViewUrl: String?
    let trackViewUrl: String?
    let previewUrl: String?
    let artworkUrl30, artworkUrl60, artworkUrl100: String?
    let collectionPrice, trackPrice: Double?
    let releaseDate: String?
    let collectionExplicitness, trackExplicitness: String?
    let discCount, discNumber, trackCount, trackNumber: Int?
    let trackTimeMillis: Int?
    let country: String?
    let currency: String?
    let isStreamable: Bool?
    let primaryGenreName: String?
    let contentAdvisoryRating: String?
    let collectionArtistId: Int?
    let collectionArtistViewUrl: String?

}
