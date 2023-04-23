//
//  KeychainErrors.swift
//  MobileUP test
//
//  Created by дэвид Кихтенко on 24.04.2023.
//

import Foundation

enum KeychainErrors: Error {
    case notSave
    case notFound
    case notDelete
}

extension KeychainErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notSave:
            return "token don't save"
        case .notFound:
            return "token not found"
        case .notDelete:
            return "token don't delete"
        }
    }
}
