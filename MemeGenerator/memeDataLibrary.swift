//
//  memeDataLibrary.swift
//  MemeGenerator
//
//  Created by User17 on 2019/6/15.
//  Copyright © 2019 hsumax0216. All rights reserved.
//

import Foundation
struct memeData: Codable{
    var user:String?
    var title:String?
    var imageName: String?
    var memeImageName: String?
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static func saveToFile(memes: [memeData]) {
        let propertyEncoder = PropertyListEncoder()
        if let data = try? propertyEncoder.encode(memes) {
            let url = memeData.documentsDirectory.appendingPathComponent("MEME").appendingPathExtension("plist")
            try? data.write(to: url)
        }
    }
    
    static func readLoversFromFile() -> [memeData]? {
        let propertyDecoder = PropertyListDecoder()
        let url = memeData.documentsDirectory.appendingPathComponent("MEME").appendingPathExtension("plist")
        if let data = try? Data(contentsOf: url), let memes = try? propertyDecoder.decode([memeData].self, from: data) {
            return memes
        }
        else {
            return nil
        }
    }
}
