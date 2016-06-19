//
//  LoggedUserController.swift
//  bòlètlandy
//
//  Created by nikenson midi on 6/15/16.
//  Copyright © 2016 nikenson midi. All rights reserved.
//

import UIKit

class LoggedUserController: UIViewController {
    var url:String!
    var request: ServerRequest!
    var user:String!
    var session: String!

    @IBOutlet weak var userGreetingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //User logout when going back to the loging view
        self.navigationItem.hidesBackButton = true
        let backbtn = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Bordered, target: self, action: "logout")
        self.navigationItem.leftBarButtonItem = backbtn
        //Set the greeting label 
        userGreetingLabel.text = "Hey \(user)"
        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func logout()
    {
        //Get user inputs then transform them into data request for Post request transport
        url  = "https://klpnfamily.com/api/logout"
       request.getDataFromGet(url)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    /*
    // MARK: - Navigation
    */
       override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toGenerate" {
            if let destination = segue.destinationViewController as? GenerateLottoViewController {
                destination.session = session
                destination.user = user
                destination.request = request
            }
        }else if segue.identifier == "toTestLuck" {
            if let destination = segue.destinationViewController as? TestLuckViewController {
                destination.session = session
                destination.user = user
                destination.request = request
            }

        }
    }//end of prepareForSegue
 

}
