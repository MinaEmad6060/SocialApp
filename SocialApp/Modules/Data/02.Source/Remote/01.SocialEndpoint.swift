//
//  01.Endpoint.swift
//  SocialApp
//
//  Created by Mina Emad on 16/02/2025.
//

import Foundation
import Moya

enum SocialEndpoint {
    case getUsers
    case getUserAlbums(userId: Int)
    case getAlbumPhotos(albumId: Int)
}

extension SocialEndpoint: TargetType {
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }

    var path: String {
        switch self {
        case .getUsers:
            return "/users"
        case .getUserAlbums:
            return "/albums"
        case .getAlbumPhotos:
            return "/photos"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        switch self {
        case .getUserAlbums(let userId):
            return .requestParameters(parameters: ["userId": userId], encoding: URLEncoding.queryString)
        case .getAlbumPhotos(let albumId):
            return .requestParameters(parameters: ["albumId": albumId], encoding: URLEncoding.queryString)
        default:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}


