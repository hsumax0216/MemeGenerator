//
//  postrespondViewController.swift
//  
//
//  Created by User24 on 2019/6/13.
//

import UIKit

class postrespondViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
    
}
