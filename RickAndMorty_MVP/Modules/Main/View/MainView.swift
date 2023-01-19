//
//  MainView.swift
//  RickAndMorty_MVP
//
//  Created by Fran on 18/1/23.
//

import UIKit

class MainView: BaseView {
    // IBOutlets
    @IBOutlet weak var itemsList: UICollectionView!
    // Variables
    private let sectionInsets = UIEdgeInsets(
        top: 20,
        left: 10,
        bottom: 10,
        right: 10
    )
    lazy private var presenter: MainPresenterInterface = MainPresenter(delegate: self)
    private let list: [ItemMainListModel] = [
        .init(image: .init(imageLiteralResourceName: "personajes"), label: "Personajes"),
        .init(image: .init(imageLiteralResourceName: "episodios"), label: "Episodios")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Rick and Morty"
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: view.frame.width - 20, height: 100)
        collectionViewLayout.sectionInset = sectionInsets
        collectionViewLayout.minimumLineSpacing = 20
        itemsList.collectionViewLayout = collectionViewLayout
        itemsList.register(.init(nibName: "ItemMainListCell", bundle: nil), forCellWithReuseIdentifier: "ItemMainListCell")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? ListView else {
            return
        }
        if let response = sender as? ResponseModel<CharacterModel> {
            destination.typeView = .characters
            destination.title = "Personajes"
            destination.info = response.info
            destination.list = response.results
        } else if let response = sender as? ResponseModel<EpisodeModel> {
            destination.typeView = .episodes
            destination.title = "Episodios"
            destination.info = response.info
            destination.list = response.results
        }
    }
}

extension MainView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemMainListCell", for: indexPath) as? ItemMainListCell else { return .init() }
        cell.configure(list[indexPath.row])
        return cell
    }
}

extension MainView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        view.showProgress()
        if self.list[indexPath.row].label == "Personajes" {
            presenter.getAllCharacters()
        } else if self.list[indexPath.row].label == "Episodios" {
            presenter.getAllEpisodes()
        }
    }
}

extension MainView: MainPresenterDelegate {
    func allCharacters(_ responseCharacters: ResponseModel<CharacterModel>) {
        self.performSegue(withIdentifier: "list", sender: responseCharacters)
    }
    
    func allEpisodes(_ responseEpisodes: ResponseModel<EpisodeModel>) {
        self.performSegue(withIdentifier: "list", sender: responseEpisodes)
    }
}
