//
//  Article.swift
//  Pippin
//
//  Created by Will Brandin on 1/22/20.
//  Copyright © 2020 SchoolConnect. All rights reserved.
//

import Foundation

struct Article: Codable {
    let id: String
    let publishedDate: String
    let body: String
    let subtitle: String
    let title: String
    let author: String
    let school: String
    let imgUrl: String?
    let sourceUrl: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case publishedDate, body, subtitle, title, author, school, imgUrl, sourceUrl
    }
}
