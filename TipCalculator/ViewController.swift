//
//  ViewController.swift
//  TipCalculator
//
//  Created by Connie Shi on 6/27/14.
//
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var totalTextField : UITextField
    @IBOutlet var taxPctTextField : UITextField
    @IBOutlet var resultsTextView : UITextView
    @IBOutlet var splitSilder: UISlider
    @IBOutlet var splitLabel: UILabel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Tip Calculator"
        refreshUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func calculateTapped(sender : AnyObject) {
        tipCalc.total = Double(totalTextField.text.bridgeToObjectiveC().doubleValue)
        let possibleTips = tipCalc.returnPossibleTips()
        let possibleBills = tipCalc.returnPossibleBills()
        var results = "Total bill "
        if (tipCalc.split > 1) {
            results += " split \(tipCalc.split) ways "
        }
        results += "is:\n"

        var keys = Array(possibleTips.keys)
        sort(keys)
        for tipPct in keys {
            let tipValue = possibleTips[tipPct]!
            let prettyTipValue = String(format:"%.2f", tipValue)
            let finalVal = possibleBills[tipPct]!
            let prettyFinalVal = String(format:"%.2f", finalVal)
            results += "\(tipPct)%: $\(prettyTipValue), final sum: $\(prettyFinalVal)\n"
        }
        resultsTextView.text = results
    }
        
    @IBAction func splitChanged(sender: AnyObject) {
        tipCalc.split = Int(splitSilder.value)
        refreshUI()
        calculateTapped(sender)
    }
    
    @IBAction func totalChanged(sender: AnyObject) {
        calculateTapped(sender)
    }
    
    @IBAction func taxChanged(sender: AnyObject) {
        calculateTapped(sender)
    }
    
    @IBAction func viewTapped(sender : AnyObject) {
        totalTextField.resignFirstResponder()
    }

    let tipCalc = TipCalculatorModel(total: 0, taxPct: 0, split:1)
    
    func refreshUI() {
        totalTextField.text = String(tipCalc.total)
        resultsTextView.text = ""
        taxPctTextField.text = String(tipCalc.taxPct)
        if (splitSilder.value > 1) {
            splitLabel.text = "Split \(Int(splitSilder.value)) ways"
        } else {
         splitLabel.text = "Split \(Int(splitSilder.value)) way"
        }
    }
}

