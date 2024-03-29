//
//  savePresentViewController.swift
//  MemeGenerator
//
//  Created by User20 on 2019/6/16.
//  Copyright © 2019 hsumax0216. All rights reserved.
//

import UIKit
import Social
import FBSDKCoreKit
import FBSDKShareKit
class savePresentViewController: UIViewController {
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    var memedata: memeData?
    override func viewDidLoad() {
        super.viewDidLoad()
         //let photo = SharePhoto.init()
        if let memedata = memedata{
            navigationItem.title = memedata.title
            usernameLabel.text = memedata.user
            let url = memeData.documentsDirectory.appendingPathComponent(memedata.memeImageName!).appendingPathExtension("jpeg")
            memeImageView.image = UIImage(contentsOfFile: url.path)
            let urluser = memeData.documentsDirectory.appendingPathComponent(memedata.imageName!).appendingPathExtension("jpeg")
            userImageView.image = UIImage(contentsOfFile: urluser.path)
            /*photo.image = UIImage(contentsOfFile: url.path)
            photo.caption = memedata.title
            photo.isUserGenerated = false*/
        }
        /*let uuuu = NSURL(string: "https://stackoverflow.com/a/45263496/1724845")
        let content = ShareLinkContent.init()
        content.contentURL = uuuu! as URL
        let shareButtom = FBSendButton.init()
        shareButtom.shareContent = content
        let cG = CGPoint(x: 44, y: 610)
        shareButtom.center = cG
        print(self.view.center)
        self.view.addSubview(shareButtom)*/
        /*let uuuu = NSURL(string: "https://stackoverflow.com/a/45263496/1724845")
        let content = ShareLinkContent.init()
        content.contentURL = uuuu! as URL*/
        /*let content = ShareMediaContent.init()
        content.media = [photo]
        let shareButtom = FBShareButton.init()
        shareButtom.shareContent = content
        let cG = CGPoint(x: 44, y: 610)
        shareButtom.center = cG
        print(self.view.center)
        self.view.addSubview(shareButtom)
        if shareButtom.isHidden{
            print("shareButtom isHidden")
        }
        else{
            print("shareButtom notHidden")
        }
        if shareButtom.isEnabled{
            print("shareButtom isEnabled")
        }
        else{
            print("shareButtom notEnabled")
        }*/
        // Do any additional setup after loading the view.
    }
    
    @IBAction func albumSave(_ sender: Any) {
        if let image = memeImageView.image{
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
    }
    
    @IBAction func showShareOptions(sender: AnyObject) {
        let actionSheet = UIAlertController(title: "", message: "Share your Meme", preferredStyle: UIAlertController.Style.actionSheet)
        let albumAction = UIAlertAction(title: "Save to Ablum", style: UIAlertAction.Style.default) {(action) -> Void in
            if let image = self.memeImageView.image{
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            }
        }
        let moreAction = UIAlertAction(title: "Share", style: UIAlertAction.Style.default) { (action) -> Void in
            let activityItem: [AnyObject] = [self.memeImageView.image as AnyObject]
            let activityViewController = UIActivityViewController(activityItems: (activityItem as AnyObject) as! [Any], applicationActivities: nil)
            
            self.present(activityViewController, animated: true, completion: nil)
        }
        let dismissAction = UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel) { (action) -> Void in
            
        }
        actionSheet.addAction(albumAction)
        actionSheet.addAction(moreAction)
        actionSheet.addAction(dismissAction)
        present(actionSheet, animated: true, completion: nil)
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
