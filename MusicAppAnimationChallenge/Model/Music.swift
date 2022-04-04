//
//  Music.swift
//  MusicAppAnimationChallenge
//
//  Created by Ali Aghamirbabaei on 4/3/22.
//

import Foundation

struct Music: Identifiable {
    var id = UUID().uuidString
    var artist: String = "Imagine Dragons"
    var musicName: String
    var artwork: String
    var lyrics: String
}
