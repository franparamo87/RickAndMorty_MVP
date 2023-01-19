//
//  EpisodeModel.swift
//  RickAndMorty_MVP
//
//  Created by Fran on 18/1/23.
//

import Foundation

struct EpisodeModel: Codable {
    var id: Int
    var name: String
    var airDate: String
    var episode: String
    var characters: [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case airDate = "air_date"
        case episode
        case characters
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        episode = try container.decode(String.self, forKey: .episode)
        airDate = try container.decode(String.self, forKey: .airDate)
        characters = try container.decode([String].self, forKey: .characters)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(episode, forKey: .episode)
        try container.encode(airDate, forKey: .airDate)
        try container.encode(characters, forKey: .characters)
    }
}
