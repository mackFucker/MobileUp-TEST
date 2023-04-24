//
//  AuthenticationViewController.swift
//  MobileUP test
//
//  Created by дэвид Кихтенко on 25.04.2023.
//

import UIKit

final class AuthenticationViewController: UIViewController {
    
    override func loadView() {
        view = AuthenticationView(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
   
    override func viewWillDisappear(_ animated: Bool) {
         self.navigationController?.setNavigationBarHidden(false, animated: animated)
         super.viewWillDisappear(animated)
    }
}

extension AuthenticationViewController: AuthenticationViewOutput {
    func openVKAuth() {
        let webView = AuthenticationWebViewController()
        self.navigationController?.pushViewController(webView, animated: true)
    }
}
