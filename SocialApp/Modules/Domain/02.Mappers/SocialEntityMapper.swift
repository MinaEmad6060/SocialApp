//
//  SocialEntityMapper.swift
//  SocialApp
//
//  Created by Mina Emad on 17/02/2025.
//

//MARK: - Profile-Mapper
extension User {
    func toDomain() -> UserDomain {
        return UserDomain(
            id: self.id,
            name: self.name,
            address: self.address?.toDomain())
    }
}

extension UserAddress {
    func toDomain() -> UserAddressDomain {
        return UserAddressDomain(
            street: self.street,
            suite: self.suite,
            city: self.city,
            zipcode: self.zipcode)
    }
}


//MARK: - Album-Mapper
extension Album {
    func toDomain() -> AlbumDomain {
        return AlbumDomain(
            userId: self.userId,
            id: self.id,
            title: self.title)
    }
}

//MARK: - Photo-Mapper
extension Photo {
    func toDomain() -> PhotoDomain {
        return PhotoDomain(
            albumId: self.albumId,
            id: self.id,
            title: self.title,
            url: self.url,
            thumbnailUrl: self.thumbnailUrl)
    }
}
