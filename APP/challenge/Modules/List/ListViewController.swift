//
//  ListViewController.swift
//  challenge
//
//  Created by Wagner Sales on 29/01/24.
//

import UIKit

final class ListViewController: WASTableViewController {
    // MARK: Properties

    var viewModel: ListInputProtocol

    var refreshControl = UIRefreshControl()
    var errorView: UIView?

    // MARK: Constructors

    private init(viewModel: ListInputProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    static func create(with viewModel: ListInputProtocol) -> ListViewController {
        let viewController = ListViewController(viewModel: viewModel)
        viewController.viewModel.viewController = viewController
        return viewController
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }

    override func setupUI() {
        super.setupUI()
        setupRefreshControl()
    }

    override func setupTableView() {
        super.setupTableView()
        tableView.dataSource = self
        tableView.register(BannerCell.self, forCellReuseIdentifier: BannerCell.identifier)
        tableView.register(ListCell.self, forCellReuseIdentifier: ListCell.identifier)
    }

    // MARK: Internal Methods

    @objc
    func pullToRefresh() {
        self.viewModel.pullToRefresh()
    }

    // MARK: Private Methods

    private func setupRefreshControl() {
        self.refreshControl.addTarget(self, action: #selector(self.pullToRefresh), for: .valueChanged)
        self.tableView.addSubview(refreshControl)
    }

    private func stopLoading() {
        activityIndicator.stopAnimating()
        refreshControl.endRefreshing()
    }

    private func removeErrorView() {
        errorView?.alpha = 0
        errorView?.removeFromSuperview()
        errorView = nil
    }
}

// MARK: - UITableViewDataSource

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        let row = viewModel.rows[indexPath.row]

        switch row {
        case .banner(let viewModel):
            let bannerCell = tableView.dequeueReusableCell(withIdentifier: BannerCell.identifier) as? BannerCell
            bannerCell?.setup(with: viewModel)
            cell = bannerCell

        case .collection(let viewModel):
            let listCell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier) as? ListCell
            listCell?.setup(with: viewModel)
            cell = listCell
        }

        return cell ?? UITableViewCell()
    }
}

// MARK: - WASErrorViewDelegate

extension ListViewController: WASErrorViewDelegate {
    func didTapReloadButton() {
        viewModel.didTapReload()
    }
}

// MARK: - ListOutnputProtocol

extension ListViewController: ListOutputProtocol {
    func setTitle(_ title: String) {
        navigationItem.title = title
    }

    func startLoading() {
        activityIndicator.startAnimating()
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.tableView.alpha = 0
            self?.removeErrorView()
        }
    }

    func success() {
        stopLoading()
        tableView.reloadData()
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.tableView.alpha = 1
            self?.removeErrorView()
        }
    }

    func failure() {
        stopLoading()
        guard errorView == nil else { return }

        errorView = WASErrorView(delegate: self)
        errorView?.alpha = 0
        errorView?.fill(on: view)

        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.errorView?.alpha = 1
            self?.tableView.alpha = 0
        }
    }
}
