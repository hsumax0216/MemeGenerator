//
//  postmemeDetailViewController.swift
//  MemeGenerator
//
//  Created by User17 on 2019/6/12.
//  Copyright © 2019 hsumax0216. All rights reserved.
//

import UIKit

class postmemeDetailViewController: UIViewController {
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var allahuAkbar: UITextField!
    var allAHUAKBARPP = "Lhs7tMrR3ehLHEK"
    var meme: Meme?
    var postData:[String:String]!
    var respondData:NSDictionary?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let meme = meme{
            navigationItem.title = meme.name
            let task = URLSession.shared.dataTask(with: meme.url) { (data, response , error) in
                if let data = data {
                    DispatchQueue.main.async {
                        self.imageview.image = UIImage(data: data)
                    }
                }
            }
            task.resume()
        }
        
        // Do any additional setup after loading the view.
    }
    @IBAction func postest(_ sender: Any) {
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
            postData = ["template_id":meme!.id,"username":"hsumax0610","password":"Lhs7tMrR3ehLHEK","text0":"132","text1":"645"]
        /*}*/
        let postString = postData.compactMap({ (key, value) -> String in
            return "\(key)=\(value)"
        }).joined(separator: "&")
        request.httpBody = postString.data(using: .utf8)
        // 后面不解释了，和GET的注释一样
        let task = session.dataTask(with: request) {(data, response, error) in
            
            do {
                let r = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                print(r)
                self.respondData = r
                            } catch {
                print("無法連接到伺服器")
                return
            }
        }
        task.resume()
    }
    

    
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as? postrespondViewController
        //controller?.testing = 123
        //print("testing")
        //print()
        //print(respondData as Any)
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
        postData = ["template_id":meme!.id,"username":"hsumax0610","password":"Lhs7tMrR3ehLHEK","text0":"132","text1":"645"]
        /*}*/
        let postString = postData.compactMap({ (key, value) -> String in
            return "\(key)=\(value)"
        }).joined(separator: "&")
        request.httpBody = postString.data(using: .utf8)
        // 后面不解释了，和GET的注释一样
        let task = session.dataTask(with: request) {(data, response, error) in
            
            do {
                let r = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                print(r)
                //self.respondData = r
                controller?.respondData = r
                //print(controller?.respondData)
            } catch {
                print("無法連接到伺服器")
                return
            }
            
        }
        task.resume()
       
     }
    
 

}
