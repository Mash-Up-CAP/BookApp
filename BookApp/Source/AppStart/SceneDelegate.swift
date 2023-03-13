//
//  SceneDelegate.swift
//  BookApp
//
//  Created by Julia on 2023/03/07.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        let searchBookViewController = SearchBookViewController()
        searchBookViewController.view.backgroundColor = .systemBackground
        let navigationController = UINavigationController(rootViewController: searchBookViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

}

