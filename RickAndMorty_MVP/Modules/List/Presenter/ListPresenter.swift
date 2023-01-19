//
//  ListPresenter.swift
//  RickAndMorty_MVP
//
//  Created by Fran on 18/1/23.
//

import Foundation

protocol ListPresenterDelegate: AnyObject {
    func allCharacters(_ responseCharacters: ResponseModel<CharacterModel>)
    func allEpisodes(_ responseEpisodes: ResponseModel<EpisodeModel>)
    func character(_ character: CharacterModel)
    func episode(_ episode: EpisodeModel)
}

protocol ListPresenterInterface: AnyObject {
    func getAllCharacters(_ page: Int?)
    func getAllEpisodes(_ page: Int?)
    func getCharacter(_ id: Int)
    func getEpisode(_ id: Int)
}

class ListPresenter: ListPresenterInterface {
    private let rickMortServices = RickMortServices.shared
    private let typeView: EnumTypeView
    private let controlErrors: ControlErrorsInterface = ControlErrors()
    weak private var listPresenterDelegate: ListPresenterDelegate?
    
    init(delegate: ListPresenterDelegate?, _ typeView: EnumTypeView) {
        self.listPresenterDelegate = delegate
        self.typeView = typeView
    }
    
    func getAllCharacters(_ page: Int?) {
        rickMortServices.getAllCharacters(page) { [weak self] response in
            self?.listPresenterDelegate?.allCharacters(response)
        } failureHandler: { [weak self] error in
            self?.controlErrors.showAlertError(error as NSError)
        }
    }
    
    func getAllEpisodes(_ page: Int?) {
        rickMortServices.getAllEpisodes(page) { [weak self] response in
            self?.listPresenterDelegate?.allEpisodes(response)
        } failureHandler: { [weak self] error in
            self?.controlErrors.showAlertError(error as NSError)
        }
    }
    
    func getCharacter(_ id: Int) {
        rickMortServices.getCharacters([id]) { [weak self] characters in
            guard let character = characters.first else { return }
            self?.listPresenterDelegate?.character(character)
        } failureHandler: { [weak self] error in
            self?.controlErrors.showAlertError(error as NSError)
        }
    }
    
    func getEpisode(_ id: Int) {
        rickMortServices.getEpisodes([id]) { [weak self] episodes in
            guard let episode = episodes.first else { return }
            self?.listPresenterDelegate?.episode(episode)
        } failureHandler: { [weak self] error in
            self?.controlErrors.showAlertError(error as NSError)
        }
    }
}
