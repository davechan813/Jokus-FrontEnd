//
//  FeedViewController.swift
//  Jokus
//
//  Created by Apple on 13/03/2018.
//  Copyright © 2018 Jokus. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    @IBOutlet weak var UserImageBtn: UIButton!
    @IBOutlet weak var FriendImageBtn: UIButton!
    
    @IBOutlet weak var CommentContainer: UIView!
    @IBOutlet weak var LikeContainer: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        LikeContainer.layer.cornerRadius = 20;
        LikeContainer.layer.borderWidth = 0.5
        LikeContainer.layer.borderColor = UIColor.clear.cgColor
        
        CommentContainer.layer.cornerRadius = 20;
        CommentContainer.layer.borderWidth = 0.5
        CommentContainer.layer.borderColor = UIColor.clear.cgColor
        
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
