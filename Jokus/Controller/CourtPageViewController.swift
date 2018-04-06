//
//  CourtPageViewController.swift
//  Jokus
//
//  Created by Apple on 25/03/2018.
//  Copyright © 2018 Jokus. All rights reserved.
//

import UIKit

class CourtPageViewController: UIViewController {

    @IBOutlet weak var InvitationBtn: UIButton!
    
    @IBOutlet weak var UberBtn: UIButton!
    @IBOutlet weak var LyftBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UberBtn.layer.cornerRadius = 10;
        UberBtn.layer.borderWidth = 0.5;
        UberBtn.layer.borderColor = UIColor.clear.cgColor;
        
        LyftBtn.layer.cornerRadius = 10;
        LyftBtn.layer.borderWidth = 0.5;
        LyftBtn.layer.borderColor = UIColor.clear.cgColor;
        
        InvitationBtn.layer.cornerRadius = 35;
        InvitationBtn.layer.borderWidth = 0.5;
        InvitationBtn.layer.borderColor = UIColor.clear.cgColor;
        
        
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
