//
//  SearchResults.swift
//  Demo-White&Fluffy
//
//  Created by Михаил Зайцев on 07.06.2022.
//

struct SearchResults: Decodable {
    let total: Int
    let results: [UnsplashPhoto]
}

struct UnsplashPhoto: Decodable {
    let id: String
    let created_at: String
    let width: Int
    let height: Int
    let urls: [URLKind.RawValue:String]
    let likes: Int
    
    enum URLKind: String {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}

