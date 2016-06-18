//
//  GenerateLottoViewController.swift
//  bòlètlandy
//
//  Created by nikenson midi on 6/16/16.
//  Copyright © 2016 nikenson midi. All rights reserved.
//

import UIKit

class GenerateLottoViewController: UIViewController, UIPickerViewDelegate {
    var session: String!
    var url:String!
    var request: ServerRequest!
    var user:String!
    var numberOfLottoData:[Int]!
    var lottoTypeData:[String]!
    var numberOfLotto:Int!
    var typeOfLotto:String!
    var arrayOfLotto:[String]!
    
    
    @IBOutlet weak var numberOfLottoPicker: UIPickerView!
    @IBOutlet weak var lottoTypePicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        numberOfLottoPicker.delegate = self
        lottoTypePicker.delegate = self
        numberOfLottoData = Array(1...20)
        lottoTypeData = ["Mega", "Power"]
       
    }
    
    // The number of columns of data (for both pickerview)
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        if pickerView == lottoTypePicker {
            return 1
        }else{
             return 1
        }
       
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == lottoTypePicker {
            return lottoTypeData.count
        }else{
             return numberOfLottoData.count
        }
       
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == lottoTypePicker {
            return lottoTypeData[row]
        }else{
            return String(numberOfLottoData[row])
        }

        
    }
    // Catpure the picker view selection
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == lottoTypePicker {
          typeOfLotto = "\(numberOfLottoData[row])"
        }else {
          numberOfLotto = numberOfLottoData[row]
        }

        
    }

    
    /**
     *getLuckySet function takes the ranges of the 5 main numbers and the the bonus
     * number for either power or mega. It then returns an array that contains 6 random
     * numbers which account for one set or one play.
     **/
    func getLuckySet(mainMax:UInt32, bonusMax:UInt32)-> [Int]{
        var luckyNumbers = [Int]()
        var first = Int(arc4random_uniform(mainMax) + 1)
        
        while luckyNumbers.count < 5 {
            if !luckyNumbers.contains(first){
                luckyNumbers.append(first)
            }
            
            let remain = Int(mainMax) - first
            first = Int(arc4random_uniform(UInt32(remain)) + 1)
            
        }
        luckyNumbers.sortInPlace()
        
        let head:UInt32 = 1
       let range:UInt32 = bonusMax - head
        //Bonus number
        luckyNumbers.append(Int(arc4random_uniform(range)+head))
        return luckyNumbers
    }

    @IBAction func generateLotto(sender: AnyObject)
    {
//        var max:[UInt32] = (typeOfLotto == "Mega" ? [75,15] : [69,26])
         arrayOfLotto = [String]()
        numberOfLotto = 7
        var max:[UInt32] =  [75,15]
        
        repeat{
            numberOfLotto = numberOfLotto - 1
            let s = getLuckySet(max[0], bonusMax:max[1]).map{String($0)}.joinWithSeparator(" ")
            arrayOfLotto.append(s)
            
        }while numberOfLotto > 1
    
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "generate" {
            if let destination = segue.destinationViewController as? LottoListViewController{
                destination.arrayOfLotto = arrayOfLotto
            }
        }
    }
 

}
