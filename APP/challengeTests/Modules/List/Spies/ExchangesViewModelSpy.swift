//
//  ListViewModelSpy.swift
//  challengeTests
//
//  Created by Wagner Sales on 30/01/24.
//

import XCTest
@testable import challenge

final class ListViewModelSpy: ListInputProtocol {
    var receivedMessages: [Message] = []
    let expectation: XCTestExpectation?

    var viewController: ListOutputProtocol?
    var rows: [ListRows] = []

    init(expectation: XCTestExpectation? = nil) {
        self.expectation = expectation
    }

    func viewDidLoad() {
        receivedMessages.append(.viewDidLoad)
    }

    func requestList() {
        receivedMessages.append(.requestList)
    }

    func didSelectRow(indexPath: IndexPath) {
        receivedMessages.append(.didSelecteRow)
    }

    func didTapReload() {
        receivedMessages.append(.didTapReload)
    }

    func didTapCancelSearch() {
        receivedMessages.append(.didTapCancelSearch)
    }

    func didTapSearch(text: String?) {
        receivedMessages.append(.didTapSearch)
    }

    func pullToRefresh() {
        receivedMessages.append(.pullToRefresh)
    }
}

extension ListViewModelSpy {
    enum Message {
        case viewDidLoad
        case requestList
        case didSelecteRow
        case didTapReload
        case didTapCancelSearch
        case didTapSearch
        case pullToRefresh
    }
}
