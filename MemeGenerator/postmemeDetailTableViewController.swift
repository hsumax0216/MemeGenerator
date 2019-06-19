//
//  postmemeDetailTableViewController.swift
//  MemeGenerator
//
//  Created by User17 on 2019/6/19.
//  Copyright © 2019 hsumax0216. All rights reserved.
//

import UIKit

class postmemeDetailTableViewController: UITableViewController,UITextFieldDelegate{
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
                    let identif = "postResondedTable"
                    let controller = self.storyboard?.instantiateViewController(withIdentifier: identif) as? postrespondTableViewController
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
   
/*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
*/
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
