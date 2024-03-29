//
//  localFileMemeDataTableViewController.swift
//  MemeGenerator
//
//  Created by User17 on 2019/6/15.
//  Copyright © 2019 hsumax0216. All rights reserved.
//

import UIKit

class localFileMemeDataTableViewController: UITableViewController {
    var memedatas = [memeData]()
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        memedatas.remove(at: indexPath.row)
        
        memeData.saveToFile(memes: memedatas)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    override func viewWillAppear(_ animated: Bool) {
        viewDidLoad()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let memedatas = memeData.readLoversFromFile(){
            self.memedatas = memedatas
        }
        else {
            print("memedata reload fail")
        }
        self.tableView.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
/*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }*/

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return memedatas.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memeDataCell", for: indexPath) as! localFileMemeTableViewCell
        let memedata = memedatas[indexPath.row]
        //cell.memeTitleLabel.text
        cell.userTextLabel.text = memedata.user
        cell.memeTitleLabel.text = memedata.title
        let url = memeData.documentsDirectory.appendingPathComponent(memedata.imageName!).appendingPathExtension("jpeg")
        print("imageName:")
        print(memedata.imageName!)
        // Configure the cell...
        cell.userImage.image = UIImage(contentsOfFile: url.path)
        let url2 = memeData.documentsDirectory.appendingPathComponent(memedata.memeImageName!).appendingPathExtension("jpeg")
        print("memeImage Path:"+url2.path)
        print("memeImageName:")
        print(memedata.memeImageName!)
        cell.memePreview.image = UIImage(contentsOfFile: url2.path)
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
         let controller = segue.destination as? savePresentViewController
         controller?.memedata = memedatas[row]
         }
    }
    

}
