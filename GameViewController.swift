//
//  GameViewController.swift
//  OperatingOperators
//
//  Created by Cameron Palk on 11/15/15.
//  Copyright © 2015 Cameron Palk. All rights reserved.
//

import UIKit

struct equation {
    var numOne: Int
    var operators: Array<Character>
    var numTwo: Int
    var result: Int
}

let Operators: Array<Character> = [ "+", "−", "×", "÷" ]



class GameViewController: UIViewController {
    
    @IBOutlet var roundLabel: UILabel!
    
    @IBOutlet var progressView: UIProgressView!
    
    @IBOutlet var operatorTop_out: UIButton!
    @IBOutlet var operatorMid_out: UIButton!
    @IBOutlet var operatorBot_out: UIButton!
    
    @IBOutlet var numOne: UILabel!
    @IBOutlet var numTwo: UILabel!
    @IBOutlet var result: UILabel!
    
    

    required init(coder aDecoder: NSCoder) {
        round = 1
        correctButton = 0
        
        super.init(coder: aDecoder)!
    }
    
    
    var gameInProgress = false
    var round: Int
    var correctButton: Int
    
    var timer: NSTimer!
    var time: Float = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startRound(round: 1)
        
        
        operatorTop_out.setTitleColor(UIColor(red: 231, green: 0, blue: 0, alpha: 1), forState: UIControlState.Disabled)
        operatorMid_out.setTitleColor(UIColor(red: 231, green: 0, blue: 0, alpha: 1), forState: UIControlState.Disabled)
        operatorBot_out.setTitleColor(UIColor(red: 231, green: 0, blue: 0, alpha: 1), forState: UIControlState.Disabled)
    }
    
    @IBAction func exitGame(sender: UIButton) {
        print("Going to exit")
        
        print("Done");
    }
    
    
    func startRound(round round: Int) {
        setupForRound(round: round)
        gameInProgress = true;
        startTimer()
    }
    
    
    func startTimer() {
        time = 0.0
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("setTimer"), userInfo: nil, repeats: true)
    }
    
    func setTimer() {
        time += 0.01
        progressView.progress = Float(time / 5.0)
        if ( time > 5 ) {
            timer.invalidate()
            roundLose()
        }
    }
    
    
    
    @IBAction func topOperatorClicked() {
        if ( !gameInProgress ) { return; }
        
        timer.invalidate()
        
        if ( correctButton == 0 ) {
            roundWin()
            startRound(round: ++round)
        }
        else {
            operatorTop_out.enabled = false
            roundLose()
        }
    }
    
    @IBAction func midOperatorClicked() {
        if ( !gameInProgress ) { return; }
        
        timer.invalidate()
        
        if ( correctButton == 1 ) {
            roundWin()
            startRound(round: ++round)
        }
        else {
            operatorMid_out.enabled = false
            roundLose()
        }
    }
    
    @IBAction func botOperatorClicked() {
        if ( !gameInProgress ) { return; }
        
        timer.invalidate()
        
        if ( correctButton == 2 ) {
            roundWin()
            startRound(round: ++round)
        }
        else {
            
            operatorBot_out.enabled = false
            
            roundLose()
        }
    }
    
    
    func roundWin() {
        print("You win this round");
        progressView.progress = 0
    }
    
    func roundLose() {
        print("You lose this round");
    }
    
    
    func setupForRound(round round: Int) {
        operatorTop_out.enabled = true
        operatorMid_out.enabled = true
        operatorBot_out.enabled = true
        
        let equation = getFunction()
        
        roundLabel.text = "Round \(round)"
        
        numOne.text = "\(equation.numOne)"
        numTwo.text = "\(equation.numTwo)"
        result.text = "\(equation.result)"
        
        operatorTop_out.setTitle("\(equation.operators[0])", forState: .Normal)
        operatorMid_out.setTitle("\(equation.operators[1])", forState: .Normal)
        operatorBot_out.setTitle("\(equation.operators[2])", forState: .Normal)
        
    }
    
    func getFunction() -> equation {
        var numOne: Int = 0
        var numTwo: Int = 0
        var result = Int(arc4random_uniform(100) + 1)
        
        var operators_copy: Array<Character> = Operators
        
        var randomOperatorOne: Character
        var randomOperatorTwo: Character
        var randomOperatorThree: Character
        
        randomOperatorOne = operators_copy.removeAtIndex( Int(rand()) % operators_copy.count );
        randomOperatorTwo = operators_copy.removeAtIndex( Int(rand()) % operators_copy.count );
        randomOperatorThree = operators_copy.removeAtIndex( Int(rand()) % operators_copy.count );
        
        
        let ops: Array<Character> = [
            randomOperatorOne,
            randomOperatorTwo,
            randomOperatorThree
        ]
        
        print( ops );
        
        
        correctButton = Int(arc4random_uniform(3))
        
        switch ops[correctButton] {
        case "+":
            numOne = Int(arc4random_uniform(UInt32(result) + 1)) + 1
            numTwo = result - numOne
            break
        case "−":
            numTwo = Int(arc4random_uniform(UInt32(result) + 1)) + 1
            numOne = result + numTwo
            break;
        case "×":
            numOne = Int(arc4random_uniform(UInt32(10) + 1)) + 1
            numTwo = Int(arc4random_uniform(UInt32(10) + 1)) + 1
            result = numOne * numTwo
            break;
        case "÷":
            repeat {
                numTwo = Int(arc4random_uniform(UInt32(10))) + 1
                result = Int(result / numTwo)
                numOne = result * numTwo
            } while ( result > 100 )
            break;
        default:
            print("The equation was wrong")
            break;
        }
        
        
        
        
        return equation(numOne: numOne, operators: ops, numTwo: numTwo, result: result)
    }
    
    
}