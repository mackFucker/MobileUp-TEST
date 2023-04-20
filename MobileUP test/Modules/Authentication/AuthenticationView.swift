//
//  OnboardingView.swift
//  MobileUP test
//
//  Created by дэвид Кихтенко on 19.04.2023.
//

import UIKit

protocol AuthenticationViewOutput: AnyObject {
    func openVKAuth()
}

final class AuthenticationView: UIView {
    
     weak var delegate: AuthenticationViewOutput?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var mobileUpLable: UILabel = {
        let mobileUpLable = UILabel()
        mobileUpLable.font = UIFont.boldSystemFont(ofSize: 44)
        mobileUpLable.adjustsFontForContentSizeCategory = true
        mobileUpLable.text = """
        Mobile Up
        Gallery
        """
        mobileUpLable.lineBreakStrategy = .hangulWordPriority
        mobileUpLable.numberOfLines = 2
        mobileUpLable.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mobileUpLable)
        return mobileUpLable
    }()
    
    private lazy var loginVK: UIButton = {
        let loginVK = UIButton()
        loginVK.backgroundColor = .label
        loginVK.layer.cornerRadius = 10
        loginVK.setTitle("Вход через VK", for: .normal)
        loginVK.setTitleColor(.systemBackground, for: .normal)
        loginVK.translatesAutoresizingMaskIntoConstraints = false
        loginVK.addTarget(self, action: #selector(openWebViewVK), for: .touchUpInside)
        addSubview(loginVK)
        return loginVK
    }()
    
    @objc
    private  func openWebViewVK() {
        delegate?.openVKAuth()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        NSLayoutConstraint.activate([
            mobileUpLable.topAnchor.constraint(equalTo: topAnchor, constant: 170),
            mobileUpLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            mobileUpLable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            loginVK.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            loginVK.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            loginVK.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -42),
            loginVK.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
}
