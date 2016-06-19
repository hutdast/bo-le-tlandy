//
//  ViewController.swift
//  bòlètlandy
//
//  Created by nikenson midi on 6/12/16.
//  Copyright © 2016 nikenson midi. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var accessButton: UIButton!
    
  
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorLoginLabel: UILabel!
    var token:String!
    var url:String!
    var response:String!
    var json:NSDictionary!
   let request = ServerRequest()
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Get api token as required for authentication
         url = "https://klpnfamily.com/api"
        json = request.getDataFromGet(url)
        token = json["token"] as! String
       
    }
    /**
     * Disable the continue button in the event the user logout or start the app anew and set the errorlogingLable to nothing
     **/
    override func viewWillAppear(animated: Bool) {
          UIView.animateWithDuration(2.0, delay: 0.2, options: UIViewAnimationOptions.CurveEaseInOut, animations: {self.image.frame.origin.y = 200}, completion:nil)
        
        //Disable the accessButton so user woould not be able to access (or segue) to the application without authentication
        accessButton.enabled = false
        errorLoginLabel.text = ""
    }
    
    /**
     * Enable App access thru server side validation. LogUser makes a request using ServerRequest
     * Then based on the response user get authenticated or else an error message is sent back to the user.
    **/
 
    @IBAction func logUser(sender: AnyObject)
    {
        self.view.endEditing(true)
        //Get user inputs then transform them into data request for Post request transport
        let post:String = "username=\(usernameField.text!)&password=\(passwordField.text!)&_token=\(token)"
       url  = "https://klpnfamily.com/api/login"
         json = request.getDataFromPost(url, dataString: post)
         response = json["response"] as! String
      errorLoginLabel.textColor =  (response == "success" ?  UIColor.greenColor() : UIColor.redColor() )
        
        errorLoginLabel.text = " \(response)"
        accessButton.enabled = (response == "success" ? true :false)
        if response == "success"{
        self.performSegueWithIdentifier("toAuthArea", sender: sender)
        }
        
    }
    

    
    /**
     * If server authenticate user then we segue and transfer session token over to the next board.
     * 
    **/
 
    
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
     {
        url  = "https://klpnfamily.com/api/check"
        json = request.getDataFromGet(url)
         response = json["response"] as! String
        
       
        if segue.identifier == "toAuthArea" {
            if let destination = segue.destinationViewController as? LoggedUserController {
                destination.request = request
                destination.user = usernameField.text!
                destination.session =   (response == "checked" ? json["session"] as! String : "none")
            }
        }//End of segue identifier
        
     }
 
    
    
    
    
    
    

        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

