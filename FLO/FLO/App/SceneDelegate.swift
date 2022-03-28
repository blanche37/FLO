//
//  SceneDelegate.swift
//  FLO
//
//  Created by yun on 2022/03/12.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let repository: Repository = NetworkRepository()
        let service: Service = FLOService(repository: repository)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as? ViewController
        let viewModel: ViewModel = FLOViewModel(service: service)
        viewController?.viewModel = viewModel
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}
