//
//  ListRowViewModelMock.swift
//  challengeTests
//
//  Created by Wagner Sales on 30/01/24.
//

@testable import challenge

extension ListRows {
    static var mock: ListRows {
        .banner(viewModel: .init(title: "", thumbnailURL: ""))
    }
}

extension Array where Element == ListRows {
    static var mock: [ListRows] {
        [.mock]
    }
}
