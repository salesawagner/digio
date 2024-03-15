//
//  ListViewModelTests.swift
//  challengeTests
//
//  Created by Wagner Sales on 30/01/24.
//

import XCTest
import API
@testable import challenge

final class ListViewModelTests: XCTestCase {
    private func makeSUT(api: APIClient, expectation: XCTestExpectation? = nil) -> (
        ListViewModel,
        ListViewControllerSpy
    ) {
        let viewControllerSpy = ListViewControllerSpy(expectation: expectation)
        let sut = ListViewModel(api: api, name: "Maria")
        sut.viewController = viewControllerSpy

        return (sut, viewControllerSpy)
    }

    func test_viewDidLoad_success_shouldReceiveCorrectMessages() {
        let expectation = XCTestExpectation(description: "viewDidLoad_success")
        let (sut, viewControllerSpy) = makeSUT(api: WASAPI(environment: Environment.local), expectation: expectation)
        sut.viewDidLoad()

        let result = XCTWaiter.wait(for: [expectation], timeout: 1)
        switch result {
        case .completed:
            XCTAssertEqual(viewControllerSpy.receivedMessages, [.setTitle, .startLoading, .success])
        default:
            XCTFail("Delegate not called within timeout")
        }
    }

    func test_requestList_startLoading_shouldReceiveCorrectMessages() {
        let (sut, viewControllerSpy) = makeSUT(api: WASAPI(environment: Environment.local))
        sut.viewDidLoad()

        XCTAssertEqual(viewControllerSpy.receivedMessages, [.setTitle, .startLoading])
    }

    func test_viewDidLoad_requestList_success_shouldReceiveCorrectMessages() {
        let expectation = XCTestExpectation(description: "requestList_success")
        let (sut, viewControllerSpy) = makeSUT(api: WASAPI(environment: Environment.local), expectation: expectation)
        sut.viewDidLoad()

        let result = XCTWaiter.wait(for: [expectation], timeout: 1)
        switch result {
        case .completed:
            XCTAssertTrue(viewControllerSpy.receivedMessages.contains(.success))
        default:
            XCTFail("Delegate not called within timeout")
        }
    }

    func test_viewDidLoad_requestList_failure_shouldReceiveCorrectMessages() {
        let expectation = XCTestExpectation(description: "requestList_failure")
        let (sut, viewControllerSpy) = makeSUT(api: WASAPIMock(), expectation: expectation)
        sut.viewDidLoad()

        let result = XCTWaiter.wait(for: [expectation], timeout: 1)
        switch result {
        case .completed:
            XCTAssertTrue(viewControllerSpy.receivedMessages.contains(.failure))
        default:
            XCTFail("Delegate not called within timeout")
        }
    }

    func test_pullToRefresh_requestList_success_shouldReceiveCorrectMessages() {
        let expectation = XCTestExpectation(description: "requestList_success")
        let (sut, viewControllerSpy) = makeSUT(api: WASAPI(environment: Environment.local), expectation: expectation)
        sut.pullToRefresh()

        let result = XCTWaiter.wait(for: [expectation], timeout: 1)
        switch result {
        case .completed:
            XCTAssertTrue(viewControllerSpy.receivedMessages.contains(.success))
        default:
            XCTFail("Delegate not called within timeout")
        }
    }

    func test_pullToRefresh_requestList_failure_shouldReceiveCorrectMessages() {
        let expectation = XCTestExpectation(description: "requestList_failure")
        let (sut, viewControllerSpy) = makeSUT(api: WASAPIMock(), expectation: expectation)
        sut.pullToRefresh()

        let result = XCTWaiter.wait(for: [expectation], timeout: 1)
        switch result {
        case .completed:
            XCTAssertTrue(viewControllerSpy.receivedMessages.contains(.failure))
        default:
            XCTFail("Delegate not called within timeout")
        }
    }

    func test_didTapReload_requestList_success_shouldReceiveCorrectMessages() {
        let expectation = XCTestExpectation(description: "requestList_success")
        let (sut, viewControllerSpy) = makeSUT(api: WASAPI(environment: Environment.local), expectation: expectation)
        sut.didTapReload()

        let result = XCTWaiter.wait(for: [expectation], timeout: 1)
        switch result {
        case .completed:
            XCTAssertTrue(viewControllerSpy.receivedMessages.contains(.success))
        default:
            XCTFail("Delegate not called within timeout")
        }
    }

    func test_didTapReload_requestList_failure_shouldReceiveCorrectMessages() {
        let expectation = XCTestExpectation(description: "requestList_failure")
        let (sut, viewControllerSpy) = makeSUT(api: WASAPIMock(), expectation: expectation)
        sut.didTapReload()

        let result = XCTWaiter.wait(for: [expectation], timeout: 1)
        switch result {
        case .completed:
            XCTAssertTrue(viewControllerSpy.receivedMessages.contains(.failure))
        default:
            XCTFail("Delegate not called within timeout")
        }
    }
}
