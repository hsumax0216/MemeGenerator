import UIKit
// 这个session可以使用刚才创建的。
let session = URLSession(configuration: .default)
// 设置URL
let url = "https://api.imgflip.com/caption_image"
var request = URLRequest(url: URL(string: url)!)
request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
request.httpMethod = "POST"
// 设置要post的内容，字典格式
let postData = ["template_id":"61579","username":"hsumax0610","password":"Lhs7tMrR3ehLHEK","text0":"123","text1":"456"]
let postString = postData.compactMap({ (key, value) -> String in
    return "\(key)=\(value)"
}).joined(separator: "&")
request.httpBody = postString.data(using: .utf8)
// 后面不解释了，和GET的注释一样
let task = session.dataTask(with: request) {(data, response, error) in
    do {
        let r = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
        print(r)
    } catch {
        print("無法連接到伺服器")
        return
    }
}
task.resume()
