//
//  String+.swift
//  MobileUP test
//
//  Created by дэвид Кихтенко on 26.04.2023.
//

import Foundation

extension String {
    func localized() -> String {
        NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
