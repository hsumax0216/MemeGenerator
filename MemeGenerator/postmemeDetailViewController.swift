//
//  postmemeDetailViewController.swift
//  MemeGenerator
//
//  Created by User17 on 2019/6/12.
//  Copyright © 2019 hsumax0216. All rights reserved.
//

import UIKit

class postmemeDetailViewController: UIViewController ,UITextFieldDelegate{
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var allahuAkbar: UITextField!
    var allAHUAKBARPP = "Lhs7tMrR3ehLHEK"//MSAZQc5ubhrY
    var user = "hsumax0610"//brotherbot0614
    var meme: Meme?
    var signinwith:String?
    var postData:[String:String]!
    var respondData:getMemeRespond?
    override func viewDidLoad() {
        super.viewDidLoad()
        signinwith = user
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        	self.view.endEditing(true)
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
       if let toptext = topText.text,let bottomtext = bottomText.text,toptext != "" || bottomtext != ""{
            if usernameText.text != "" || allahuAkbar.text != ""{
                user = usernameText.text!
                signinwith = user
                allAHUAKBARPP = allahuAkbar.text!
            }
            print("text inputed")
        print("logIn with:"+user+" "+allAHUAKBARPP)
            postData = ["template_id":meme!.id,"username":user,"password":allAHUAKBARPP,"text0":toptext,"text1":bottomtext]
        }
        else{
        print("text uninput")
            postData = ["template_id":meme!.id,"username":user,"password":allAHUAKBARPP,"text0":" ","text1":" "]
        }
        let postString = postData.compactMap({ (key, value) -> String in
            return "\(key)=\(value)"
        }).joined(separator: "&")
        request.httpBody = postString.data(using: .utf8)
        // 后面不解释了，和GET的注释一样
        let task = session.dataTask(with: request) {(data, response, error) in
            
           do {
                let r = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    //self.respondData = respondResult
            let decoder = JSONDecoder()
            if let data = data ,let respondResult = try? decoder.decode(getMemeRespond.self, from: data){
                //responddata = respondResult
                //let identif = "postResonded"
                //let controller = storyboard?.instantiateViewController(withIdentifier: identif) as? postrespondViewController
                let identif = "postResonded"
                let controller = self.storyboard?.instantiateViewController(withIdentifier: identif) as? postrespondViewController
                DispatchQueue.main.async {
                    //controller?.respondData = self.respondData
                    controller?.signinwith = self.signinwith
                    controller?.respondData = respondResult
                    //controller?.testing = 159
                    self.navigationController?.pushViewController(controller!, animated: true)
                }
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
    }
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let controller = segue.destination as? postrespondViewController
               
     }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
