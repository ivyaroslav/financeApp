//
//  StoreError.swift
//  financeApp
//
//  Created by yaroslav on 17/09/2026.
//
import Foundation
enum StoreError: Error {
    case accountNotFound
    case transactionNotFound
    case corruptedUserData
}
