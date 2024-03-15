//
//  BannerCell.swift
//  challenge
//
//  Created by Wagner Sales on 29/01/24.
//

import UIKit

final class BannerCell: UITableViewCell {
    static var identifier = String(describing: BannerCell.self)

    // MARK: Properties

    private let titleLabel = UILabel()
    private let thumbnailView = UIImageView()
    private let thumbnail = UIImageView()

    // MARK: Inits

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnail.image = nil
        thumbnail.backgroundColor = .clear
    }

    // MARK: Private Methods

    private func setupUI() {
        setupThumbnail()
        setupLabels()
        setupStackView()
        selectionStyle = .none
        contentView.backgroundColor = .clear
        backgroundColor = .clear
    }

    private func setupThumbnail() {
        let size = 100.0
        thumbnail.contentMode = .scaleAspectFill
        thumbnail.clipsToBounds = true
        thumbnail.layer.cornerRadius = 8
        thumbnail.fill(on: thumbnailView, insets: .init(top: 0, left: 16, bottom: 16, right: 16))

        NSLayoutConstraint.activate([
            thumbnail.heightAnchor.constraint(equalToConstant: size)
        ])
    }

    private func setupLabels() {
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = .Base.title
    }

    private func setupStackView() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.spacing = 16

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(thumbnailView)

        stackView.fill(on: contentView)
    }

    // MARK: Internal Methods

    func setup(with viewModel: ItemViewModel) {
        thumbnail.loadFromUrl(stringURL: viewModel.thumbnailURL)
        titleLabel.text = viewModel.title
    }
}
