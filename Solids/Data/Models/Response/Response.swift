//
//  Response.swift
//
//  Created by Asad Hayat on 09/03/2022.
//

import Foundation

// Base reponse model

struct BaseResponse : Codable {
    let status : String?
    let content : [Article]?
    let serverTime : Int?
}
