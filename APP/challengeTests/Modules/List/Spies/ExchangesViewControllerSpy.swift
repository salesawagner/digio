//
//  ListViewControllerSpy.swift
//  challengeTests
//
//  Created by Wagner Sales on 30/01/24.
//

import XCTest
@testable import challenge

final class ListViewControllerSpy: ListOutputProtocol {
    var receivedMessages: [Message] = []
    let expectation: XCTestExpectation?

    init(expectation: XCTestExpectation? = nil) {
        self.expectation = expectation
    }

    func setTitle(_ title: String) {
        receivedMessages.append(.setTitle)
    }

    func startLoading() {
        receivedMessages.append(.startLoading)
    }

    func success() {
        receivedMessages.append(.success)
        expectation?.fulfill()
    }

    func failure() {
        receivedMessages.append(.failure)
        expectation?.fulfill()
    }

    func update(section: Int) {
        receivedMessages.append(.updateSection)
    }
}

extension ListViewControllerSpy {
    enum Message {
        case setTitle
        case startLoading
        case success
        case failure
        case updateSection
    }
}
