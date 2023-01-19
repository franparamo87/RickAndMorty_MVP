//
//  DetailsPresenter.swift
//  RickAndMorty_MVP
//
//  Created by Fran on 18/1/23.
//

import Foundation

protocol DetailsPresenterDelegate: AnyObject {
    func location(_ location: CharacterModel.Location)
}

protocol DetailsPresenterInterface: AnyObject {
    func getLocation(_ id: Int)
}

class DetailsPresenter: DetailsPresenterInterface {
    private let rickMortServices = RickMortServices.shared
    private let typeView: EnumTypeView
    private let controlErrors: ControlErrorsInterface = ControlErrors()
    weak private var detailsPresenterDelegate: DetailsPresenterDelegate?
    
    init(delegate: DetailsPresenterDelegate?, _ typeView: EnumTypeView) {
        self.detailsPresenterDelegate = delegate
        self.typeView = typeView
    }
    
    func getLocation(_ id: Int) {
        rickMortServices.getLocations([id]) { [weak self] locations in
            guard let location = locations.first else { return }
            self?.detailsPresenterDelegate?.location(location)
        } failureHandler: { [weak self] error in
            self?.controlErrors.showAlertError(error as NSError)
        }

    }
}
