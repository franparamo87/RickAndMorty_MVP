//
//  CharacterModel.swift
//  RickAndMorty_MVP
//
//  Created by Fran on 18/1/23.
//

import Foundation

struct CharacterModel: Codable {
    var id: Int
    var name: String
    var status: String
    var gender: String
    var type: String
    var species: String
    var image: String
    var episode: [String]
    var origin: Location
    var location: Location
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case gender
        case type
        case image
        case species
        case episode
        case origin
        case location
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        status = try container.decode(String.self, forKey: .status)
        gender = try container.decode(String.self, forKey: .gender)
        type = try container.decode(String.self, forKey: .type)
        species = try container.decode(String.self, forKey: .species)
        image = try container.decode(String.self, forKey: .image)
        episode = try container.decode([String].self, forKey: .episode)
        origin = try container.decode(Location.self, forKey: .origin)
        location = try container.decode(Location.self, forKey: .location)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(status, forKey: .status)
        try container.encode(gender, forKey: .gender)
        try container.encode(type, forKey: .type)
        try container.encode(species, forKey: .species)
        try container.encode(image, forKey: .image)
        try container.encode(episode, forKey: .episode)
        try container.encode(origin, forKey: .origin)
        try container.encode(location, forKey: .location)
    }
    
    struct Location: Codable {
        var id: Int?
        var name: String
        var url: String
        var type: String?
        var dimension: String?
    }
}

