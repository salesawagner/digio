//
//  CollectionCell.swift
//  challenge
//
//  Created by Wagner Sales on 29/01/24.
//

import UIKit

final class CollectionCell: UICollectionViewCell {
    static var identifier = String(describing: CollectionCell.self)

    // MARK: Properties

    private let thumbnail = UIImageView()

    // MARK: Inits

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnail.image = UIImage(named: "noImage")
        thumbnail.backgroundColor = .clear
    }

    // MARK: Private Methods

    private func setupUI() {
        setupThumbnail()
        contentView.backgroundColor = .clear
        backgroundColor = .clear
    }

    private func setupThumbnail() {
        thumbnail.contentMode = .scaleAspectFill
        thumbnail.clipsToBounds = true
        thumbnail.layer.cornerRadius = 16
        thumbnail.image = UIImage(named: "noImage")

        let shadowView = UIView()
        shadowView.backgroundColor = .clear
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.2
        shadowView.layer.shadowRadius = 4
        shadowView.layer.shadowOffset = .init(width: 0, height: 4)

        thumbnail.fill(on: shadowView)
        shadowView.fill(on: contentView, insets: .all(constant: 8))
    }

    // MARK: Internal Methods

    func setup(with viewModel: ItemViewModel) {
        thumbnail.loadFromUrl(stringURL: viewModel.thumbnailURL)
    }
}
