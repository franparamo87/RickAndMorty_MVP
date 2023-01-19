//
//  RickMortServices.swift
//  RickAndMorty_MVP
//
//  Created by Fran on 18/1/23.
//

import Foundation
import Alamofire

class RickMortServices {
    static let shared = RickMortServices()
    
    func getAllCharacters(_ page: Int? = nil, successHandler: @escaping (ResponseModel<CharacterModel>)->(), failureHandler: @escaping (Error)->()) {
        var parameters: Parameters = [:]
        if let page = page {
            parameters = ["page": page]
        }
        AF.request("https://rickandmortyapi.com/api/character/", parameters: parameters, encoding: URLEncoding.queryString).responseDecodable(of: ResponseModel<CharacterModel>.self) {
            switch $0.result {
            case .success(let value):
                successHandler(value)
            case .failure(let error):
                failureHandler(error)
            }
        }
    }
    
    func getCharacters(_ ids: [Int], successHandler: @escaping ([CharacterModel])->(), failureHandler: @escaping (Error)->()) {
        if ids.isEmpty {
            failureHandler(NSError.create("Array empty", code: 2424, function: #function, file: #file, line: #line))
            return
        }
        AF.request("https://rickandmortyapi.com/api/character/" + ids.compactMap({String(describing: $0)}).joined(separator: ",")).responseData{
            switch $0.result {
            case .success(let data):
                do {
                    if ids.count > 1 {
                        let array = try JSONDecoder().decode([CharacterModel].self, from: data)
                        successHandler(array)
                    } else {
                        let obj = try JSONDecoder().decode(CharacterModel.self, from: data)
                        successHandler([obj])
                    }
                } catch {
                    failureHandler(error)
                }
            case .failure(let error):
                failureHandler(error)
            }
        }
    }
    
    func getAllEpisodes(_ page: Int? = nil, successHandler: @escaping (ResponseModel<EpisodeModel>)->(), failureHandler: @escaping (Error)->()) {
        var parameters: Parameters = [:]
        if let page = page {
            parameters = ["page": page]
        }
        AF.request("https://rickandmortyapi.com/api/episode/", parameters: parameters, encoding: URLEncoding.queryString).responseDecodable(of: ResponseModel<EpisodeModel>.self) {
            switch $0.result {
            case .success(let value):
                successHandler(value)
            case .failure(let error):
                failureHandler(error)
            }
        }
    }
    
    func getEpisodes(_ ids: [Int], successHandler: @escaping ([EpisodeModel])->(), failureHandler: @escaping (Error)->()) {
        if ids.isEmpty {
            failureHandler(NSError.create("Array empty", code: 2424, function: #function, file: #file, line: #line))
            return
        }
        AF.request("https://rickandmortyapi.com/api/episode/" + ids.compactMap({String(describing: $0)}).joined(separator: ",")).responseData {
            switch $0.result {
            case .success(let data):
                do {
                    if ids.count > 1 {
                        let array = try JSONDecoder().decode([EpisodeModel].self, from: data)
                        successHandler(array)
                    } else {
                        let obj = try JSONDecoder().decode(EpisodeModel.self, from: data)
                        successHandler([obj])
                    }
                } catch {
                    failureHandler(error)
                }
            case .failure(let error):
                failureHandler(error)
            }
        }
    }
    
    func getLocations(_ ids: [Int], successHandler: @escaping ([CharacterModel.Location])->(), failureHandler: @escaping (Error)->()) {
        if ids.isEmpty {
            failureHandler(NSError.create("Array empty", code: 2424, function: #function, file: #file, line: #line))
            return
        }
        AF.request("https://rickandmortyapi.com/api/location/" + ids.compactMap({String(describing: $0)}).joined(separator: ",")).responseData {
            switch $0.result {
            case .success(let data):
                do {
                    if ids.count > 1 {
                        let array = try JSONDecoder().decode([CharacterModel.Location].self, from: data)
                        successHandler(array)
                    } else {
                        let obj = try JSONDecoder().decode(CharacterModel.Location.self, from: data)
                        successHandler([obj])
                    }
                } catch {
                    failureHandler(error)
                }
            case .failure(let error):
                failureHandler(error)
            }
        }
    }
}
