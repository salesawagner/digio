//
//  ListProtocols.swift
//  challenge
//
//  Created by Wagner Sales on 29/01/24.
//

import Foundation

protocol ListInputProtocol {
    var viewController: ListOutputProtocol? { get set }
    var rows: [ListRows] { get }
    func didTapReload()
    func pullToRefresh()
    func viewDidLoad()
}

protocol ListOutputProtocol {
    func setTitle(_ title: String)
    func startLoading()
    func success()
    func failure()
}
