//
//  AuthenticationViewController.swift
//  MobileUP test
//
//  Created by дэвид Кихтенко on 20.04.2023.
//

import Foundation

import UIKit

final class AuthenticationViewController: UIViewController {
    
    private let onboardingView = AuthenticationView()
    
    override func loadView() {
        view = onboardingView
    }
}
