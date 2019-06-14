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
    var testing:Int?
    var respondData:NSDictionary?
    var accountText:String?
    //var meme:Meme?
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(respondData!)
        let dic = respondData as? Dictionary<String,Any>
        print("print dic")
        print(dic as Any)
        // Do any additional setup after loading the view.
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
