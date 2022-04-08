//
//  Article.swift
//  asadhayat
//
//  Created by Asad Hayat on 07/03/2022.
//

import Foundation

struct Article : Codable {
	let id : Int64?
	let title : String?
	let dateTime : String?
    var tags : [String] = []
    var content : [Item] = []
	let ingress : String?
    let image : String?
    let imageData : Data?
    let descrip : String?
	let created : Int64?
	let changed : Int64?
}
