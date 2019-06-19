//
//  postrespondTableViewController.swift
//  MemeGenerator
//
//  Created by User17 on 2019/6/19.
//  Copyright © 2019 hsumax0216. All rights reserved.
//

import UIKit

class postrespondTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate ,UITextFieldDelegate{
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var memeTitleTextField: UITextField!
    @IBOutlet weak var photoButton: UIButton!
    var testing:Int?
    var signinwith:String?
    var respondData:getMemeRespond?
    var respondResult:NSDictionary?
    var accountText:String?
    var meme:memeData?
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as? UIImage
        photoButton.setBackgroundImage(image, for: .normal)
        dismiss(animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
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
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let user = accountLabel.text ?? ""
        let Title = memeTitleTextField.text ?? ""
        let imageName = UUID().uuidString
        let imageData = photoButton.backgroundImage(for: .normal)?.jpegData(compressionQuality: 0.8)
        let memeImageName = UUID().uuidString
        let memeImageData = imageview.image?.jpegData(compressionQuality: 0.8)
        let url = memeData.documentsDirectory.appendingPathComponent(imageName).appendingPathExtension("jpeg")
        let url2 = memeData.documentsDirectory.appendingPathComponent(memeImageName).appendingPathExtension("jpeg")
        print("Image Path:"+url.path)
        print("memeImage Path:"+url2.path)
        try? imageData?.write(to: url)
        do{ try memeImageData?.write(to: url2)}catch{print("memeImageData write fail")}
        meme = memeData(user: user,title: Title, imageName: imageName, memeImageName: memeImageName)
        
    }
    @IBAction func SelectImage(_ sender: Any) {
        let controller = UIImagePickerController()
        controller.sourceType = .photoLibrary
        controller.allowsEditing = true
        controller.delegate = self
        present(controller, animated: true, completion: nil)
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
