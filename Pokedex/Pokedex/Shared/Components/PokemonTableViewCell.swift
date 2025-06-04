//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by Pedro Franco on 31/05/25.
//

import UIKit

final class PokemonTableViewCell: UITableViewCell {
    private let pokemonCell: PokemonCellView = {
        let cell = PokemonCellView()
        cell.translatesAutoresizingMaskIntoConstraints = false
        return cell
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCell() {
        contentView.addSubview(pokemonCell)
        NSLayoutConstraint.activate([
            pokemonCell.topAnchor.constraint(equalTo: contentView.topAnchor),
            pokemonCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pokemonCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pokemonCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func configure(_ pokemon: Pokemon) {
        pokemonCell.configure(pokemon)
    }
}
