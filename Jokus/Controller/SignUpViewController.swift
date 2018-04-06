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
//        UserDefaults.standard.removeObject(forKey:"myLoginToken")
//        print("Clear All Data!")
        
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
//        UserDefaults.standard.set(userEmail, forKey:"userEmail");
//        UserDefaults.standard.set(userPassword, forKey:"userPassword");
//        UserDefaults.standard.synchronize();
        
        let parameters = ["firstName" : "A",
                          "lastName" :  "a",
                          "email" : userEmail,
                          "password" : userPassword,
                          "height" : "63",
                          "weight" : "144",
                          "position" : "C"]
        let url = "http://damianx-env.us-east-2.elasticbeanstalk.com/add"
        var retStr = ""
        
        Alamofire.request(url, method:.post, parameters : parameters, encoding: URLEncoding.default).responseString { response in switch response.result {
              case .success:
                retStr = response.result.value!
                print ("retStr: ", retStr)
                
                if (retStr == "-1") {
                    self.displayAlert(userMessage: "The Email has been used!")
                    return
                } else {
                    // Store This String as Token
                    UserDefaults.standard.set(retStr, forKey:"loginToken");
//                    let loginToken = UserDefaults.standard.string(forKey: "myLoginToken")!;
//                    print("myLoginToken: ", myLoginToken)
                    
                    // display alert message with comfirmation
                    let successAlert = UIAlertController(title:"Cool!", message: "Registration is successful!", preferredStyle: UIAlertControllerStyle.alert)
                    let successAction = UIAlertAction(title:"Jokus!", style:UIAlertActionStyle.default) { action in
                        self.dismiss(animated: true, completion: nil);
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
        var myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(myPickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        //        playButton.setImage(UIImage(named: "play.png"), for: .normal)
        UserImageButton.setImage(info[UIImagePickerControllerOriginalImage] as? UIImage, for: .normal)
        
        self.dismiss(animated: true, completion: nil)
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
