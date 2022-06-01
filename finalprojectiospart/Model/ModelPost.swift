//
//  SwiftUIViewPost.swift
//  finalprojectiospart
//
//  Created by Айбек on 23.05.2022.
//

import Foundation

struct ModelPost: Decodable{
    
    let userId: Int
    let postId: Int
    let title: String
    let body: String
    
    enum CodingKeys: String, CodingKey {
        case userId 
        case postId = "id"
        case title
        case body
    }
}
