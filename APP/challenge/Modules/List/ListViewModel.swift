//
//  ListViewModel.swift
//  challenge
//
//  Created by Wagner Sales on 29/01/24.
//

import API

enum ListRows {
    case banner(viewModel: ItemViewModel)
    case collection(viewModel: CollectionViewModel)
}

final class ListViewModel {
    // MARK: Properties

    private var api: APIClient
    private let title: String
    private var response: GetProductsRequest.Response?

    var viewController: ListOutputProtocol?
    var rows: [ListRows] = []

    // MARK: Inits

    init(api: APIClient = WASAPI(environment: Environment.production), name: String) {
        self.api = api
        self.title = "Olá, \(name)"
    }

    // MARK: Private Methods

    private func requestList() {
        viewController?.startLoading()
        api.send(GetProductsRequest()) { [weak self] result in
            switch result {
            case .success(let response):
                self?.response = response
                self?.rows = response.toViewModel

                DispatchQueue.main.async {
                    self?.viewController?.success()
                }
            case .failure:
                DispatchQueue.main.async {
                    self?.viewController?.failure()
                }
            }
        }
    }

    private func resetSearch() {
        requestList()
    }
}

// MARK: - ListInputProtocol

extension ListViewModel: ListInputProtocol {
    func didTapReload() {
        requestList()
    }

    func pullToRefresh() {
        requestList()
    }

    func viewDidLoad() {
        viewController?.setTitle(title)
        requestList()
    }
}

private extension GetProductsResponse {
    var toViewModel: [ListRows] {
        let spotlightItems: [ItemViewModel] = spotlight.compactMap { .init(title: $0.name, thumbnailURL: $0.bannerURL) }
        let productsItems: [ItemViewModel] = products.compactMap { .init(title: $0.name, thumbnailURL: $0.imageURL) }

        return [
            .collection(viewModel: .init(title: "", items: spotlightItems, layout: spotlightLayout)),
            .banner(viewModel: .init(title: cash.title, thumbnailURL: cash.bannerURL)),
            .collection(viewModel: .init(title: "Produtos", items: productsItems, layout: productsLayout))
        ]
    }

    private var spotlightLayout: UICollectionViewFlowLayout {
        buildLayout(size: CGSize(width: UIScreen.main.bounds.width - 20, height: 180))
    }

    private var productsLayout: UICollectionViewFlowLayout {
        buildLayout(size: CGSize(width: 150, height: 150))
    }

    private func buildLayout(size: CGSize) -> UICollectionViewFlowLayout {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal

        return layout
    }
}
