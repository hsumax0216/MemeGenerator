import UIKit
struct getMemeRespond: Codable{
    var success:Bool
    var error_message:String?
    var data:respondData?
}
struct respondData: Codable{
    var url:URL
    var page_url:URL
}
// 这个session可以使用刚才创建的。
let session = URLSession(configuration: .default)
// 设置URL
let url = "https://api.imgflip.com/caption_image"
var request = URLRequest(url: URL(string: url)!)
request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
request.httpMethod = "POST"
// 设置要post的内容，字典格式
/*if let toptext=topText.text,let bottomtext=bottomText.text{
 postData = ["template_id":meme!.id,"username":"hsumax0610","password":"Lhs7tMrR3ehLHEK","text0":toptext,"text1":bottomtext]
 }
 else{*/
let postData = ["template_id":"1jhfvj8","username":"hsumax0610","password":"Lhs7tMrR3ehLHEK","text0":"132","text1":"645"]
/*}*/
let postString = postData.compactMap({ (key, value) -> String in
    return "\(key)=\(value)"
}).joined(separator: "&")
request.httpBody = postString.data(using: .utf8)
// 后面不解释了，和GET的注释一样
//URLSession.shared.dataTask(with: <#T##URL#>)
let task = session.dataTask(with: request) {(data, response, error) in
    
     do {
    let r = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
    
    let decoder = JSONDecoder()
    if let data = data ,let respondResult = try? decoder.decode(getMemeRespond.self, from: data){
        //responddata = respondResult
        //let identif = "postResonded"
        //let controller = storyboard?.instantiateViewController(withIdentifier: identif) as? postrespondViewController
        print(respondResult.error_message as Any)
    }
    else{
        print("getMemeRespond error")
    }
    print(r)
    
            } catch {
     print("無法連接到伺服器")
     return
     }
}
task.resume()
