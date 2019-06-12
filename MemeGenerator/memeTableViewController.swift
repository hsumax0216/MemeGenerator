//
//  memeTableViewController.swift
//  MemeGenerator
//
//  Created by User17 on 2019/6/12.
//  Copyright © 2019 hsumax0216. All rights reserved.
//

import UIKit

class memeTableViewController: UITableViewController {
    var memes = [Meme]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = "https://api.imgflip.com/get_memes"
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                let decoder = JSONDecoder()
                if let data = data, let memeResults = try? decoder.decode(getMemeResult.self, from: data) {
                    self.memes = memeResults.data.memes;               DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                else{
                    print("ErrorIn")
                }
            }
            task.resume()
        }
        else{
            print("ErrorOut")
        }
      
    }

    // MARK: - Table view data source

    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }*/

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return memes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memeCell", for: indexPath) as! memeTableViewCell
        let meme = memes[indexPath.row]
        cell.memeTitle.text = meme.name
        let task = URLSession.shared.dataTask(with: meme.url) { (data, response , error) in
            if let data = data {
                DispatchQueue.main.async {
                    cell.memePreview.image = UIImage(data: data)
                }
            }
        }
        task.resume()
        return cell
    }
    

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let row = tableView.indexPathForSelectedRow?.row {
            let controller = segue.destination as? postmemeDetailViewController
            controller?.meme = memes[row]
        }
    }
    

}
