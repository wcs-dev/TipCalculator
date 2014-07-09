//
//  TipCalculatorModel.swift
//  TipCalculator
//
//  Created by Connie Shi on 6/27/14.
//
//

import Foundation

class TipCalculatorModel {
    //properties
    var total: Double
    var taxPct: Double
    var split: Int
    var subtotal: Double {
        get {
            return total / (taxPct + 1)
        }
    }

    init(total:Double, taxPct:Double, split:Int) {
        self.total = total
        self.taxPct = taxPct
        self.split = split
    }
    
    func calcTipWithTipPct(TipPct:Double) -> Double {
        return subtotal * TipPct
    }
    
    func printPossibleTips() {
        let possibleTipsInferred = [0.15, 0.18, 0.20]
        // .. is non-inclusive range operator, doens't include upper bound
        // ... is inclusive
        for i in 0 .. possibleTipsInferred.count {
            let possibleTip = possibleTipsInferred[i]
            println("\(possibleTip * 100)%: \(calcTipWithTipPct(possibleTip))")
        }
    }
    
    func returnPossibleTips() -> Dictionary<Int, Double> {
        let possibleTipsInferrd = [0.15, 0.18, 0.20]
        let possibleTipsExplicit:Double[] = [0.15, 0.18, 0.20]
        
        var retval = Dictionary<Int, Double>()
        for possibleTip in possibleTipsInferrd {
            let intPct = Int(possibleTip * 100)
            retval[intPct] = calcTipWithTipPct(possibleTip)
        }
        return retval
    }
    
    func returnPossibleBills() -> Dictionary<Int, Double> {
        let possibleTips = returnPossibleTips()
        var retval = Dictionary<Int, Double>()
        for (tipPct, tipVal) in possibleTips {
            retval[tipPct] = Double(tipVal + total) / Double(split)
        }
        return retval
        
    }
}

