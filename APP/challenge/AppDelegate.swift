//
//  AppDelegate.swift
//  mb
//
//  Created by Wagner Sales on 29/01/24.
//

import UIKit
import API

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        window = UIWindow()

        let api = WASAPI(environment: Environment.production)
        let viewController = ListViewController.create(with: ListViewModel(api: api, name: "Maria"))
        let navigationController = UINavigationController(rootViewController: viewController)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }
}
