//
//  WASTableViewController.swift
//  challenge
//
//  Created by Wagner Sales on 29/01/24.
//

import UIKit

class WASTableViewController: UIViewController {
    // MARK: Properties
    let activityIndicator = UIActivityIndicatorView()
    let tableView = UITableView(frame: .zero, style: .plain)

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: Setups

    func setupUI() {
        view.backgroundColor = UIColor.Base.background
        setupActivityIndicator()
        setupTableView()
    }

    func setupActivityIndicator() {
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .darkText
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }

    func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        tableView.alpha = 0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = 8
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorColor = .clear
        tableView.fill(on: view)
    }
}
