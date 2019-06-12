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
    var meme: Meme?
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
