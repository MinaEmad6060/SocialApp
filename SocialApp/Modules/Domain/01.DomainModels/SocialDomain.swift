//
//  SocialDomain.swift
//  SocialApp
//
//  Created by Mina Emad on 17/02/2025.
//

//MARK: - Profile-Domain
struct UserDomain {
    let id: Int?
    let name: String?
    let address: UserAddressDomain?
}

struct UserAddressDomain {
    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
}


//MARK: - Albums-Domain
struct AlbumDomain: Codable {
    let userId: Int?
    let id: Int?
    let title: String?
}


//MARK: - Photos-Domain
struct PhotoDomain {
    let albumId: Int?
    let id: Int?
    let title: String?
    let url: String?
    let thumbnailUrl: String?
}
