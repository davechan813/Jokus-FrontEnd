//
//  MessagePageViewController.swift
//  Jokus
//
//  Created by Apple on 26/03/2018.
//  Copyright © 2018 Jokus. All rights reserved.
//

import UIKit

class MessagePageViewController: UIViewController {

    @IBOutlet weak var InvitationContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        InvitationContainer.layer.cornerRadius = 15;
        InvitationContainer.layer.borderWidth = 0.5
        InvitationContainer.layer.borderColor = UIColor.clear.cgColor
        InvitationContainer.clipsToBounds = true
        
        // Do any additional setup after loading the view.
        
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
