//
//  MainPresenter.swift
//  RickAndMorty_MVP
//
//  Created by Fran on 18/1/23.
//

import Foundation

protocol MainPresenterDelegate: AnyObject {
    func allCharacters(_ responseCharacters: ResponseModel<CharacterModel>)
    func allEpisodes(_ responseEpisodes: ResponseModel<EpisodeModel>)
}

protocol MainPresenterInterface: AnyObject {
    func getAllCharacters()
    func getAllEpisodes()
}

class MainPresenter: MainPresenterInterface {
    private let rickMortServices = RickMortServices.shared
    private let controlErrors: ControlErrorsInterface = ControlErrors()
    weak private var mainPresenterDelegate: MainPresenterDelegate?
    
    init(delegate: MainPresenterDelegate?) {
        self.mainPresenterDelegate = delegate
    }
    
    func getAllCharacters() {
        rickMortServices.getAllCharacters { [weak self] response in
            self?.mainPresenterDelegate?.allCharacters(response)
        } failureHandler: { [weak self] error in
            self?.controlErrors.showAlertError(error as NSError)
        }
    }
    
    func getAllEpisodes() {
        rickMortServices.getAllEpisodes{ [weak self] response in
            self?.mainPresenterDelegate?.allEpisodes(response)
        } failureHandler: { [weak self] error in
            self?.controlErrors.showAlertError(error as NSError)
        }
    }
}
