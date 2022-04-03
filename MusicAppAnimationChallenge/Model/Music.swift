//
//  Music.swift
//  MusicAppAnimationChallenge
//
//  Created by Ali Aghamirbabaei on 4/3/22.
//

import Foundation

struct Music: Identifiable {
    var id = UUID().uuidString
    var musicTitle: String
    var artwork: String
}

var musics: [Music] = [
    Music(musicTitle: "Bones", artwork: "IG-Bones"),
    Music(musicTitle: "Enemy", artwork: "IG-Enemy"),
    Music(musicTitle: "Radioactive", artwork: "IG-Radioactive"),
    Music(musicTitle: "Believer", artwork: "IG-Believer"),
    Music(musicTitle: "Wreaked", artwork: "IG-Wreaked"),
    Music(musicTitle: "Whatever it takes", artwork: "IG-Whatever-it-takes"),
    Music(musicTitle: "I Bet My Life", artwork: "IG-I-Bet-My-Life"),
]
