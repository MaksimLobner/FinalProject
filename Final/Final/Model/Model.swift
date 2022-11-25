//
//  Model.swift
//  Final
//
//  Created by dunice-internship on 07.11.2022.
//

import Foundation
// MARK: -  My Profile
struct LogIn: Codable {
    let data: RegistrationUser
    let statusCode: Int
    let success: Bool
}
// MARK: - My Profile
struct RegistrationUser: Codable {
    let avatar: String
    let  email: String
    let id: String
    let name: String
    let role, token: String
}
//MARK: - UploadFile
struct PhotoData: Codable {
    let success: Bool
    let statusCode: Int
    let data: String
}
//MARK: - GET NEWS
struct Welcome: Codable {
    let data: DataClass
    let statusCode: Int
    let success: Bool
}

// MARK: - DataClass
struct DataClass: Codable {
    let content: [ContentNews]
    let numberOfElements: Int
}

// MARK: - Content
struct ContentNews: Codable, Identifiable {
    let contentDescription: String
    let id: Int
    let image: String
    let tags: [Tag]
    let title: String
    let username: String
    let userID: String
    
    enum CodingKeys: String, CodingKey {
        case contentDescription = "description"
        case id, image, tags, title
        case userID = "userId"
        case username
    }
}
// MARK: - Tag
struct Tag: Codable {
    let id: Int
    let title: String
}

//MARK: - Response create news
struct PostNews: Codable {
    let id, statusCode: Int
    let success: Bool
}
//MARK: - Response find news
struct FindNews: Codable {
    let content: [ContentNews]
    let numberOfElements: Int
}
//MARK: - Get Info Another User
struct AnotherUser: Codable {
    let data: AnotherUserData
    let statusCode: Int
    let success: Bool
}
struct AnotherUserData: Codable {
    var avatar: String
    var email: String
    var id: String
    var name: String
    var role: String
}

