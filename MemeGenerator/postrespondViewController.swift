//
//  postrespondViewController.swift
//  
//
//  Created by User24 on 2019/6/13.
//

import UIKit

class postrespondViewController: UIViewController {
    
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var errorLabel: UILabel!
    var testing:Int?
    var signinwith:String?
    var respondData:getMemeRespond?
    var respondResult:NSDictionary?
    var accountText:String?
    //var meme:Meme?
    override func viewDidLoad() {
        super.viewDidLoad()
        print("print")
        //print(respondData!)
        //print(respondResult!)
        //let dic = respondResult as? Dictionary<String,Any>
        //print(dic as Any)
        //if dic!["success"] == 0{
        //}
        //print(dic as Any)
        // Do any additional setup after loading the view.
        if (respondData!.success) {
            errorLabel.text = nil
            let task = URLSession.shared.dataTask(with: (respondData?.data!.url)!) { (data, response , error) in
                if let data = data {
                    DispatchQueue.main.async {
                        self.imageview.image = UIImage(data: data)
                        self.accountLabel.text = self.signinwith
                    }
                }
            }
        
            task.resume()
        }
        else{
            print("unsuccess")
            errorLabel.text = "error log : " + respondData!.error_message!
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
