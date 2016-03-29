import UIKit

class CalculatorViewController: UIViewController {
    @IBOutlet weak var displaybar: UILabel!
    @IBOutlet weak var historybar: UILabel!
    
    private var brain = CalculatorBrain()
    private var userIsInTheMiddleOfTypingANumber = false

    
    private struct DefaultDisplayResult {
        static let Startup: Double = 0
        static let Error = "Error!"
    }

    @IBAction func clear() {
        
        brain.clearStack()
        brain.variableValues.removeAll()
        displayResult = CalculatorBrainEvaluationResult.Success(DefaultDisplayResult.Startup)
        historybar.text = "No History!"
    }
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            if digit != "." || displaybar.text!.rangeOfString(".") == nil {
                displaybar.text = displaybar.text! + digit
            }
        } else {
            displaybar.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }

    @IBAction func delete() {
        if userIsInTheMiddleOfTypingANumber == true {
            if displaybar.text!.characters.count > 1 {
                displaybar.text = String(displaybar.text!.characters.dropLast())
            } else {
                displayResult = CalculatorBrainEvaluationResult.Success(DefaultDisplayResult.Startup)
            }
        } else {
            brain.removeLastOpFromStack()
            displayResult = brain.evaluateAndReportErrors()
        }
    }
    
    @IBAction func changeSign() {
        if userIsInTheMiddleOfTypingANumber {
            if displayValue != nil {
                displayResult = CalculatorBrainEvaluationResult.Success(displayValue! * -1)
                
                // set userIsInTheMiddleOfTypingANumber back to true as displayResult will set it to false
                userIsInTheMiddleOfTypingANumber = true
            }
        } else {
            displayResult = brain.performOperation("ᐩ/-")
        }
    }
    
    @IBAction func pi() {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        displayResult = brain.pushConstant("π")
    }
    
    @IBAction func setM() {
        userIsInTheMiddleOfTypingANumber = false
        if displayValue != nil {
            brain.variableValues["M"] = displayValue!
        }
        displayResult = brain.evaluateAndReportErrors()
    }
    
    @IBAction func getM() {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        displayResult = brain.pushOperand("M")
    }    
    
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            displayResult = brain.performOperation(operation)
        }
    }
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        if displayValue != nil {
            displayResult = brain.pushOperand(displayValue!)
        }
    }
    
    private var displayValue: Double? {
        if let displayValue = NSNumberFormatter().numberFromString(displaybar.text!) {
            return displayValue.doubleValue
        }
        return nil
    }
    
    private var displayResult: CalculatorBrainEvaluationResult? {
        get {
            if let displayValue = displayValue {
                return .Success(displayValue)
            }
            if displaybar.text != nil {
                return .Failure(displaybar.text!)
            }
            return .Failure("Error")
        }
        set {
            if newValue != nil {
                switch newValue! {
                case let .Success(displayValue):
                    displaybar.text = "\(displayValue)"
                case let .Failure(error):
                    displaybar.text = error
                }
            } else {
                displaybar.text = DefaultDisplayResult.Error
            }
            userIsInTheMiddleOfTypingANumber = false
            
            if !brain.description.isEmpty {
                historybar.text = " \(brain.description.joinWithSeparator(", ")) ="
            } else {
                historybar.text = "No History!"
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination: UIViewController? = segue.destinationViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController
        }
        if let gvc = destination as? GraphingViewController {
            gvc.program = brain.program
            if let graphLabel = brain.description.last {
                gvc.graphLabel = graphLabel
            }
        }
    }

}

