//
//  LoginViewController.swift
//  Jokus
//
//  Created by Apple on 11/03/2018.
//  Copyright © 2018 Jokus. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    @IBOutlet weak var UserImageView: UIImageView!
    @IBOutlet weak var UserNameUITextField: UITextField!
    @IBOutlet weak var PasswordUITextField: UITextField!
    @IBOutlet weak var LoginContainerView: UIView!
    @IBOutlet weak var SignInButton: RoundCornerButton!
    var window: UIWindow?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        UserImageView.layer.cornerRadius = UserImageView.frame.size.width / 2;
//        UserImageView.clipsToBounds = true
        
//        UserNameUITextField.layer.borderWidth = 0.1
//        UserNameUITextField.layer.borderColor = UIColor.lightGray.cgColor
//
//        PasswordUITextField.layer.borderWidth = 0.1
//        PasswordUITextField.layer.borderColor = UIColor.lightGray.cgColor
//
//
//        LoginContainerView.layer.masksToBounds = false
//        LoginContainerView.layer.shadowRadius = 2.0
//        LoginContainerView.layer.shadowColor = UIColor.lightGray.cgColor
//        LoginContainerView.layer.shadowOpacity = 0.3
        
        
        
        let userImageData = UserDefaults.standard.value(forKey: "defaultUserImage")
        let defaultUserEmail = UserDefaults.standard.value(forKey: "defaultUserEmail")
        if (userImageData != nil) {
            print("here")
            let defaultUserImage = UIImage(data: userImageData as! Data)!
            UserImageView.image = defaultUserImage
        }
        if (defaultUserEmail != nil) {
            print("here")
            UserNameUITextField.text = defaultUserEmail as? String
        }
    }
    
    func displayAlert(userMessage: String) {
        let alert = UIAlertController(title:"Oops!", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        let alertAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default, handler:nil);
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func LoginButtonTapped(_ sender: Any) {
        let userName = UserNameUITextField.text!;
        let userPassword = PasswordUITextField.text!;
// Fetch Data from UserDefaults
//        let userEmailStored = UserDefaults.standard.string(forKey: "userEmail");
//        let userPasswordStored = UserDefaults.standard.string(forKey: "userPassword");

        
//        print("userName = ", userName);
//        print("userPassword = ", userPassword);
//        print("userEmailStored = ", userEmailStored);
//        print("userPasswordStored = ", userPasswordStored);
        
        
//        if (userEmailStored == userName) {
//            if (userPassword == userPasswordStored) {
//                print("log in!")
//                UserDefaults.standard.set(true, forKey: "isUserLoggedIn");
//                UserDefaults.standard.synchronize();
//
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
////                appDelegate.window?.rootViewController = MapViewController
//                appDelegate.window?.makeKeyAndVisible()
//
//
//            }
//        }
        
        let parameters = ["email" : userName, "password" : userPassword]
        let url = "http://damianx-env.us-east-2.elasticbeanstalk.com/getToken"
        var retStr = ""
        
        Alamofire.request(url, method:.post, parameters : parameters, encoding: URLEncoding.default).responseString { response in switch response.result {
            case .success:
            retStr = response.result.value!
            print ("retStr: ", retStr)
            if (retStr == "-1") {
                self.displayAlert(userMessage: "The Password is incorrect!")
                return
            } else if (retStr == "-2") {
                self.displayAlert(userMessage: "The Email Doesn't Exist!")
                return
            } else {
                // Get loginToken from UserDefaults
                UserDefaults.standard.set(retStr, forKey:"myLoginToken");
                
                // Get loginToken from UserDefaults
//                let myLoginToken = UserDefaults.standard.string(forKey: "myLoginToken")!;
//                print("myLoginToken: ", myLoginToken)
                
                print("Login Succeed!")
                self.performSegue(withIdentifier: "mainTabView", sender: self)
            }
            break
        case .failure(let error):
            print (error)
            break
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
