//
//  Models.swift
//  StackGif
//
//  Created by Borna Libertines on 14/02/22.
//

import Foundation

// MARK: APIListResponse Model
/// model from api
struct APIListResponse: Codable {
    let data: [GifObject]
}

struct GifObject: Codable {
    let id: String?
    let title: String?
    let source_tld: String?
    let rating: String?
    let url: URL?
    let images: Images?
    struct Images: Codable {
        let fixed_height: Image?
        struct Image: Codable {
            let url: URL?
            let width: String?
            let height: String?
            let mp4: URL?
        }
    }
}

// MARK: SearchResult Model
struct SearchResult: Codable {
  let id: String?
  let gifUrl: URL?
  let title: String?
    enum CodingKeys: String, CodingKey {
        case id
        case gifUrl = "url"
        case title
    }
}


// MARK: APGifResponse Model
struct APGifResponse: Codable {
    let data: GifObject
}

// MARK: GifCollectionViewCellViewModel Model
struct GifCollectionViewCellViewModel {
    let id: String?
    let title: String?
    let rating: String?
    let Image: URL?
    let url: URL?
}
// MARK: GifViewCellViewModel Model
struct GifViewCellViewModel {
    let id: String?
    let title: String?
    let rating: String?
    let Image: URL?
    let video: URL?
    let url: URL?
}
