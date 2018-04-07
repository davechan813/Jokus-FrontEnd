//
//  SignUpViewController.swift
//  Jokus
//
//  Created by Apple on 12/03/2018.
//  Copyright © 2018 Jokus. All rights reserved.
//

import UIKit
import Alamofire

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var UserEmailTextField: UITextField!
    @IBOutlet weak var UserPasswordTextField: UITextField!
    @IBOutlet weak var RepeatPasswordTextField: UITextField!
    @IBOutlet weak var UserImageButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func displayAlert(userMessage: String) {
        let alert = UIAlertController(title:"Oops", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        let alertAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default, handler:nil);
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func SignUpButtonTapped(_ sender: Any) {
        let userEmail = UserEmailTextField.text!;
        let userPassword = UserPasswordTextField.text!;
        let repeatPassword = RepeatPasswordTextField.text!;
        
//                 Clear myLoginToken in UserDefault
        UserDefaults.standard.removeObject(forKey:"defaultUserEmail")
        UserDefaults.standard.removeObject(forKey:"defaultUserImage")
        print("Clear All Data!")
        
        // Check for empty field
        if (userEmail.isEmpty || userPassword.isEmpty || repeatPassword.isEmpty) {
            displayAlert(userMessage: "All fields are required!")
            return;
        }
    
        // Check for password matches
        if (userPassword != repeatPassword) {
            displayAlert(userMessage: "Password don't match!")
            return;
        }
        
        // store data
        UserDefaults.standard.set(userEmail, forKey:"defaultUserEmail");
        UserDefaults.standard.set(userPassword, forKey:"userPassword");
        UserDefaults.standard.synchronize();
        
        let userInfoParameters = ["firstName" : "A",
                          "lastName" :  "a",
                          "email" : userEmail,
                          "password" : userPassword,
                          "height" : "63",
                          "weight" : "144",
                          "position" : "C"]
        let userInfoUrl = "http://damianx-env.us-east-2.elasticbeanstalk.com/add"
        var userInfoRetStr = ""
        
        Alamofire.request(userInfoUrl, method:.post, parameters : userInfoParameters, encoding: URLEncoding.default).responseString { response in switch response.result {
              case .success:
                userInfoRetStr = response.result.value!
                print ("userInfoRetStr: ", userInfoRetStr)
                
                if (userInfoRetStr == "-1") {
                    self.displayAlert(userMessage: "The Email has been used!")
                    return
                } else {
                    // Store This String as Token
                    UserDefaults.standard.set(userInfoRetStr, forKey:"loginToken");
//                    let loginToken = UserDefaults.standard.string(forKey: "myLoginToken")!;
//                    print("myLoginToken: ", myLoginToken)
                    
                    // Upload User Image
                    let userImage = self.UserImageButton.imageView?.image
                    self.uploadImageToServer(image: userImage!)
                    
                    // Store Default User Email
                    UserDefaults.standard.set(userEmail, forKey:"defaultUserEmail")
                    // Store Default USer Image
                    UserDefaults.standard.register(defaults: ["defaultUserImage":UIImageJPEGRepresentation(userImage!, 1)!])
                    UserDefaults.standard.set(UIImageJPEGRepresentation(userImage!, 1), forKey: "defaultUserImage")
                    

                    // display alert message with comfirmation
                    let successAlert = UIAlertController(title:"Cool!", message: "Registration is successful!", preferredStyle: UIAlertControllerStyle.alert)
                    let successAction = UIAlertAction(title:"Jokus!", style:UIAlertActionStyle.default) { action in
                        self.performSegue(withIdentifier: "logInView", sender: self)
//                        self.dismiss(animated: true, completion: nil);
                    }
                    successAlert.addAction(successAction);
                    self.present(successAlert, animated: true, completion: nil);
                }
                break
              case .failure(let error):
                print (error)
                break
            }
        }
        
        
        
    }
    
    
    @IBAction func UserImageButtonTapped(_ sender: Any) {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(myPickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        UserImageButton.setImage(info[UIImagePickerControllerOriginalImage] as? UIImage, for: .normal)
        self.dismiss(animated: true, completion: nil)
    }
    
    func uploadImageToServer(image : UIImage) {
        let pageURL = "http://damianx-env.us-east-2.elasticbeanstalk.com/setUserProfilePic"
        
        // init paramters Dictionary
        let parameters = ["token" : "[B@54032767"]
        
        // example image data
        let imageData = UIImageJPEGRepresentation(image, 0.9)
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: .utf8)!, withName: key)
            }
            
            multipartFormData.append(imageData!, withName: "file", fileName: "userImage", mimeType: "image/jpeg")
        }, to:pageURL) { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (Progress) in
                    print("Upload Progress: \(Progress.fractionCompleted)")
                })
                
                upload.responseString { response in
                    //self.delegate?.showSuccessAlert()
                    print(response.request!)  // original URL request
                    print(response.response!) // URL response
                    print(response.data!)     // server data
                    print(response.result)   // result of response serialization
                    //                        self.showSuccesAlert()
                    //self.removeImage("frame", fileExtension: "txt")
                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
                    }
                }
                
            case .failure(let encodingError):
                //self.delegate?.showFailAlert()
                print("shit")
                print(encodingError)
            }
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
