//
//  SceneDelegate.swift
//  MobileUP test
//
//  Created by дэвид Кихтенко on 19.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var monitor = NetworkMonitor()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        self.window?.makeKeyAndVisible()
        windowScene.keyWindow?.backgroundColor = .systemBackground
                
        NetworkManager.shared.checkToken(token:  KeychainRepository.shared.getTokenFromKeychain(key: "token") ?? "") { result in
            switch result {
            case .success:
                self.showVC(isGallery: true, token: KeychainRepository.shared.getTokenFromKeychain(key: "token")!)
            case .failure:
                if self.monitor.isConnected == true {
                    KeychainRepository.shared.deleteTokenFromKeychain(key: "token")
                }
                self.showVC(isGallery: false, token: "")

            }
        }
    }
    
    private func showVC(isGallery: Bool, token: String) {
        DispatchQueue.main.async {
            var vc: UIViewController
            if isGallery {
                vc = GalleryViewController(token: token)
            } else {
                vc = AuthenticationViewController()
            }
            
            let navController = UINavigationController(rootViewController: vc)
            navController.navigationBar.prefersLargeTitles = true
            self.window?.rootViewController = navController
            
            self.addNoConnectionAlert(navController: navController)
        }
    }
    
    func addNoConnectionAlert(navController: UINavigationController) {
        if self.monitor.isConnected == false {
            let alert = UIAlertController(title: "Ошибка подключения", message: "Проверьте интернет соединение.",
                                          preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ок", style: UIAlertAction.Style.default, handler: nil))
            navController.present(alert, animated: true)
        }
    }
}
