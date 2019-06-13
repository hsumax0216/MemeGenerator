//
//  getMemeResult.swift
//  MemeGenerator
//
//  Created by User17 on 2019/6/12.
//  Copyright © 2019 hsumax0216. All rights reserved.
//

import Foundation
struct getMemeResult: Codable{
    var success:Bool
    var data:Data
}
struct Data: Codable{
    var memes:[Meme]
}
struct Meme: Codable{
    var id:String
    var name:String
    var url:URL
    var width:Int
    var height:Int
    var box_count:Int
}
struct getMemeRespond: Codable{
    var success:Bool
    var error_message:String
    var data:respondData
}
struct respondData: Codable{
    var url:URL
    var page_url:URL
}
