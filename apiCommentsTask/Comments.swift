//
//  Comments.swift
//  apiCommentsTask
//
//  Created by Mac on 16/05/23.
//

import Foundation
struct Comment : Decodable{
    var id : Int
    var post_id : Int
    var name : String
    var email : String
    var body : String
}
