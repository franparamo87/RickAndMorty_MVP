//
//  DetailsView.swift
//  RickAndMorty_MVP
//
//  Created by Fran on 18/1/23.
//

import UIKit

class DetailsView: BaseView {
    // IBOutlets
    @IBOutlet weak var stack: UIStackView!
    // Variables
    public var typeView: EnumTypeView = .unknown
    public var data: Decodable?
    lazy private var presenter:DetailsPresenterInterface = DetailsPresenter(delegate: self, typeView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stack.spacing = 10
        switch typeView {
        case .characters:
            printViewCharacter(data as! CharacterModel)
        case .episodes:
            printViewEpisode(data as! EpisodeModel)
        case .locations:
            printViewLocation(data as! CharacterModel.Location)
        default:
            break
        }
    }
    
    private func cleanStack() {
        stack.subviews.forEach { $0.removeFromSuperview() }
    }
    
    @objc private func detailsLocation(_ sender: CustomButton) {
        let button = sender
        guard let idStr = button.url?.components(separatedBy: "/").last, let id = Int(idStr) else { return }
        view.showProgress()
        presenter.getLocation(id)
    }
    
    func printViewCharacter(_ data: CharacterModel) {
        //Limpieza del stack que contiene la vista
        cleanStack()
        //Stack cabecera del personaje
        let stackHeaderCharacter = UIStackView()
        stackHeaderCharacter.axis = .horizontal
        stackHeaderCharacter.spacing = 10
        stackHeaderCharacter.distribution = .fill
        //Foto
        let photo: UIImageView = UIImageView()
        photo.load(url: URL(string: data.image)!)
        photo.clipsToBounds = true
        photo.contentMode = .scaleAspectFit
        photo.layer.cornerRadius = 30
        photo.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        stackHeaderCharacter.addArrangedSubview(photo)
        photo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photo.widthAnchor.constraint(equalToConstant: 120),
            photo.heightAnchor.constraint(equalToConstant: 140)
        ])
        //Stack info cabecera personaje
        let stackInfoHeader = UIStackView()
        stackInfoHeader.distribution = .fillProportionally
        stackInfoHeader.spacing = 10
        stackInfoHeader.axis = .vertical
        stackHeaderCharacter.addArrangedSubview(stackInfoHeader)
        if !data.status.isEmpty {
            //Estado
            let status = UILabel()
            status.text = "Estado: " + data.status
            stackInfoHeader.addArrangedSubview(status)
        }
        if !data.gender.isEmpty {
            //Género
            let gender = UILabel()
            gender.text = "Género: \(data.gender)"
            stackInfoHeader.addArrangedSubview(gender)
        }
        if !data.type.isEmpty {
            //Tipo
            let type = UILabel()
            type.numberOfLines = 0
            type.text = "Tipo: \(data.type)"
            stackInfoHeader.addArrangedSubview(type)
        }
        if !data.species.isEmpty {
            //Especie
            let species = UILabel()
            species.numberOfLines = 0
            species.text = "Especie: \(data.species)"
            stackInfoHeader.addArrangedSubview(species)
        }
        //Stack origen
        let stackOrigin = UIStackView()
        stackOrigin.spacing = 6
        stackOrigin.axis = .horizontal
        //Origen
        let origin = UILabel()
        origin.numberOfLines = 0
        origin.text = "Origen: \(data.origin.name)"
        stackOrigin.addArrangedSubview(origin)
        if !data.origin.url.isEmpty {
            //Boton mas detalle
            let buttonOrigin = CustomButton(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
            buttonOrigin.backgroundColor = .systemIndigo
            buttonOrigin.layer.cornerRadius = 10
            buttonOrigin.setTitle("Más detalles", for: .normal)
            buttonOrigin.url = data.origin.url
            buttonOrigin.addTarget(self, action: #selector(detailsLocation(_:)), for: .touchUpInside)
            stackOrigin.addArrangedSubview(buttonOrigin)
            buttonOrigin.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                buttonOrigin.widthAnchor.constraint(equalToConstant: 150),
                buttonOrigin.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
        //Stack localización
        let stackLocation = UIStackView()
        stackLocation.spacing = 6
        stackLocation.axis = .horizontal
        //Localización
        let location = UILabel()
        location.numberOfLines = 0
        location.text = "Localización: \(data.location.name)"
        stackLocation.addArrangedSubview(location)
        if !data.location.url.isEmpty {
            //Boton mas detalle
            let buttonLocation = CustomButton(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
            buttonLocation.backgroundColor = .systemIndigo
            buttonLocation.layer.cornerRadius = 10
            buttonLocation.setTitle("Más detalles", for: .normal)
            buttonLocation.url = data.location.url
            buttonLocation.addTarget(self, action: #selector(detailsLocation(_:)), for: .touchUpInside)
            stackLocation.addArrangedSubview(buttonLocation)
            buttonLocation.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                buttonLocation.widthAnchor.constraint(equalToConstant: 150),
                buttonLocation.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
        //Meter stacks informacion personaje en stack contenedor de la vista
        stack.addArrangedSubview(stackHeaderCharacter)
        stack.addArrangedSubview(stackOrigin)
        stack.addArrangedSubview(stackLocation)
    }
    
    func printViewEpisode(_ data: EpisodeModel) {
        cleanStack()
        
        if !data.episode.isEmpty {
            //Codigo
            let label = UILabel()
            label.text = "Código episodio: " + data.episode
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: 20)
            stack.addArrangedSubview(label)
        }
        if !data.airDate.isEmpty {
            //Fecha emisión
            let label = UILabel()
            label.text = "Fecha de emisión: " + data.airDate
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: 20)
            stack.addArrangedSubview(label)
        }
    }
    
    func printViewLocation(_ data: CharacterModel.Location) {
        cleanStack()
        let header = UIStackView()
        header.axis = .horizontal
        header.distribution = .fill
        let view = UIView(frame: .init(origin: .zero, size: .init(width: 160, height: 50)))
        view.backgroundColor = .clear
        header.addArrangedSubview(view)
        let buttonClose = UIButton(frame: .init(origin: .zero, size: .init(width: 50, height: 50)))
        buttonClose.setImage(.init(systemName: "xmark"), for: .normal)
        buttonClose.tintColor = .black
        buttonClose.addAction(.init(handler: { _ in
            self.dismiss(animated: true)
        }), for: .touchUpInside)
        header.addArrangedSubview(buttonClose)
        stack.addArrangedSubview(header)
        if !data.name.isEmpty {
            //Nombre
            let label = UILabel()
            label.text = data.name
            label.font = UIFont.systemFont(ofSize: 35)
            stack.addArrangedSubview(label)
        }
        if !(data.dimension ?? "").isEmpty {
            //Dimension
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 20)
            label.text = "Dimesión: " + (data.dimension ?? "")
            stack.addArrangedSubview(label)
        }
        if !(data.type ?? "").isEmpty {
            //Tipo
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 20)
            label.text = "Tipo: " + (data.type ?? "")
            stack.addArrangedSubview(label)
        }
    }
}

extension DetailsView: DetailsPresenterDelegate {
    func location(_ location: CharacterModel.Location) {
        view.dismissProgress()
        let details: DetailsView = storyboard?.instantiateViewController(withIdentifier: "details") as! DetailsView
        details.typeView = .locations
        details.data = location
        details.modalPresentationStyle = .automatic
        self.present(details, animated: true)
    }
}
