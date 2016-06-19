//
//  LottoTableViewController.swift
//  bòlètlandy
//
//  Created by nikenson midi on 6/19/16.
//  Copyright © 2016 nikenson midi. All rights reserved.
//

import UIKit
import CoreData

class LottoTableViewController: UITableViewController {
var arrayOfLotto:[String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
        self.navigationItem.rightBarButtonItem = self.editButtonItem()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       return arrayOfLotto.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("lottoCell", forIndexPath: indexPath)
        cell.textLabel?.text = arrayOfLotto[indexPath.row]
        let cellBg = UIView()
        cellBg.backgroundColor = UIColor(red: 0.0, green: 1.0, blue: 0.3, alpha: 0.6)
        cell.selectedBackgroundView = cellBg
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let alertWindow = UIAlertController(title: "Save Lotto", message: "Would you like to save this lotto? \(arrayOfLotto[indexPath.row])", preferredStyle: .ActionSheet)
        let cancelBtn = UIAlertAction(title: "Cancel", style: .Cancel, handler: {(action) in alertWindow.dismissViewControllerAnimated(true, completion: nil) })
        alertWindow.addAction(cancelBtn)
        self.presentViewController(alertWindow, animated: true, completion: nil)
        
    }

    
   
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     arrayOfLotto.removeAtIndex(indexPath.row)
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     }
        
}
 

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
