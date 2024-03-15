//
//  ListCell.swift
//  challenge
//
//  Created by Wagner Sales on 29/01/24.
//

import UIKit

final class ListCell: UITableViewCell {
    static var identifier = String(describing: ListCell.self)

    // MARK: Properties

    private let titleLabel = UILabel()
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var dataSource: [ItemViewModel] = []

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
        dataSource = []
        collectionView.reloadData()
    }

    // MARK: Private Methods

    private func setupUI() {
        setupCollectionView()
        setupLabels()
        setupStackView()
        selectionStyle = .none
        contentView.backgroundColor = .clear
        backgroundColor = .clear
    }

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.identifier)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false

        NSLayoutConstraint.activate([
            collectionView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            collectionView.heightAnchor.constraint(equalToConstant: 200)
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
        stackView.addArrangedSubview(collectionView)

        stackView.fill(on: contentView)
    }

    // MARK: Internal Methods

    func setup(with viewModel: CollectionViewModel) {
        titleLabel.text = viewModel.title
        dataSource = viewModel.items
        collectionView.collectionViewLayout = viewModel.layout
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource

extension ListCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CollectionCell.identifier, for: indexPath
        ) as? CollectionCell
        cell?.setup(with: dataSource[indexPath.row])

        return cell ?? UICollectionViewCell()
    }
}
