//
//  UserEntity.swift
//  SocialApp
//
//  Created by Mina Emad on 16/02/2025.
//

struct User: Codable {
    let id: Int?
    let name: String?
    let address: UserAddress?
}

struct UserAddress: Codable {
    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
}
