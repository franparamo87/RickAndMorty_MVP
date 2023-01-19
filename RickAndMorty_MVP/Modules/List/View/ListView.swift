//
//  ListView.swift
//  RickAndMorty_MVP
//
//  Created by Fran on 18/1/23.
//

import UIKit

class ListView: BaseView {
    // IBOutlets
    @IBOutlet weak var table: UITableView!
    // Variables
    public var typeView: EnumTypeView = .unknown
    public var list: [Decodable] = []
    public var info: Decodable?
    lazy private var presenter: ListPresenterInterface = ListPresenter(delegate: self, typeView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.separatorStyle = .none
        self.table.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        self.table.rowHeight = 80
        self.table.register(.init(nibName: "ItemListCell", bundle: nil), forCellReuseIdentifier: "ItemListCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? DetailsView else { return }
        destination.typeView = typeView
        if let data = sender as? EpisodeModel {
            destination.title = data.name
            destination.data = data
        } else if let data = sender as? CharacterModel {
            destination.title = data.name
            destination.data = data
        }
    }
}

extension ListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemListCell", for: indexPath) as? ItemListCell else { return .init() }
        if typeView == .episodes, let data = list[indexPath.row] as? EpisodeModel {
            cell.loadEpisode(data)
        } else if typeView == .characters, let data = list[indexPath.row] as? CharacterModel {
            cell.loadCharacter(data)
        }
        if indexPath.row == (list.count - 1) {
            switch typeView {
            case .characters:
                if let info = (info as? ResponseModel<CharacterModel>.Info), indexPath.row < (info.count - 1) {
                    table.isUserInteractionEnabled = false
                    view.showProgress()
                    presenter.getAllCharacters(Int((info.next?.components(separatedBy: "page=").last!)!))
                }
            case .episodes:
                if let info = (info as? ResponseModel<EpisodeModel>.Info), indexPath.row < (info.count - 1) {
                    table.isUserInteractionEnabled = false
                    view.showProgress()
                    presenter.getAllEpisodes(Int((info.next?.components(separatedBy: "page=").last!)!))
                }
            default: break
            }
        }
        return cell
    }
}

extension ListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.showProgress()
        switch typeView {
        case .characters:
            guard let data =  (list[indexPath.row] as? CharacterModel) else { return }
            self.presenter.getCharacter(data.id)
        case .episodes:
            guard let data = (list[indexPath.row] as? EpisodeModel) else { return }
            self.presenter.getEpisode(data.id)
        default:
            break
        }
    }
}


extension ListView: ListPresenterDelegate {
    func allCharacters(_ responseCharacters: ResponseModel<CharacterModel>) {
        view.dismissProgress()
        info = responseCharacters.info
        list.append(contentsOf: responseCharacters.results)
        table.isUserInteractionEnabled = true
        table.reloadData()
    }
    
    func allEpisodes(_ responseEpisodes: ResponseModel<EpisodeModel>) {
        view.dismissProgress()
        info = responseEpisodes.info
        list.append(contentsOf: responseEpisodes.results)
        table.isUserInteractionEnabled = true
        table.reloadData()
    }
    
    func character(_ character: CharacterModel) {
        performSegue(withIdentifier: "details", sender: character)
    }
    
    func episode(_ episode: EpisodeModel) {
        performSegue(withIdentifier: "details", sender: episode)
    }
}
