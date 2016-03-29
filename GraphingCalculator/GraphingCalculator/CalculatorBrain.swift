import Foundation

enum CalculatorBrainEvaluationResult {
    case Success(Double)
    case Failure(String)
}

class CalculatorBrain {
    
    private enum Op: CustomStringConvertible {
        case Operand(Double)
        case Variable(String)
        case Pi(String, Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
        
        var description: String {
            switch self {
            case .Operand(let operand):
                let intValue = Int(operand)
                if Double(intValue) == operand {
                    return "\(intValue)"
                } else {
                    return "\(operand)"
                }
            case .Variable(let symbol):
                return "\(symbol)"
            case .Pi(let symbol, _):
                return "\(symbol)"
            case .UnaryOperation(let symbol, _):
                return symbol
            case .BinaryOperation(let symbol, _):
                return symbol
            }
        }
        
        
        
        var precedence: Int {
            switch self {
            case .Operand(_), .Variable(_), .Pi(_, _), .UnaryOperation(_, _):
                return Int.max
            case .BinaryOperation(_, _):
                return Int.min
            }
        }
    }
    
    private var opStack = [Op]()
    private var knownOps = [String:Op]()
    var variableValues = [String:Double]()
    private var error: String?
    
    typealias PropertyList = AnyObject
    var program: PropertyList {
        get {
            return opStack.map { $0.description }
        }
        set {
            if let opSymbols = newValue as? [String] {
                var newOpStack = [Op]()
                for opSymbol in opSymbols {
                    if let op = knownOps[opSymbol] {
                        newOpStack.append(op)
                    } else if let operand = NSNumberFormatter().numberFromString(opSymbol)?.doubleValue {
                        newOpStack.append(.Operand(operand))
                    } else {
                        newOpStack.append(.Variable(opSymbol))
                    }
                }
                opStack = newOpStack
            }
        }
    }
    
    var description: [String] {
        let (descriptionArray, _) = description([String](), ops: opStack)
        return descriptionArray
    }
    
    init() {
        func learnOp(op: Op) {
            knownOps[op.description] = op
        }
        learnOp(Op.UnaryOperation("√", sqrt))
        learnOp(Op.UnaryOperation("SIN", sin))
        learnOp(Op.UnaryOperation("COS", cos))
        learnOp(Op.UnaryOperation("ᐩ/-") { -$0 })
        learnOp(Op.BinaryOperation("×", *))
        learnOp(Op.BinaryOperation("+", +))
        learnOp(Op.BinaryOperation("÷") { $1 / $0 })
        learnOp(Op.BinaryOperation("−") { $1 - $0 })
        learnOp(Op.UnaryOperation("x²") { $0 * $0 })
        learnOp(Op.Pi("π", M_PI))
    }
    
    private func description(currentDescription: [String], ops: [Op]) -> (descStrLst: [String], remainingOps: [Op]) {
        var descStrLst = currentDescription
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeFirst()
            switch op {
            case .Operand(_), .Variable(_), .Pi(_, _):
                descStrLst.append(op.description)
                return description(descStrLst, ops: remainingOps)
            case .UnaryOperation(let symbol, _):
                if !descStrLst.isEmpty {
                    let unaryOperand = descStrLst.removeLast()
                    descStrLst.append(symbol + "(\(unaryOperand))")
                    let (newDescription, remainingOps) = description(descStrLst, ops: remainingOps)
                    return (newDescription, remainingOps)
                }
            case .BinaryOperation(let symbol, _):
                if !descStrLst.isEmpty {
                    let binaryOperandLast = descStrLst.removeLast()
                    if !descStrLst.isEmpty {
                        let binaryOperandFirst = descStrLst.removeLast()                        
                        if op.description == remainingOps.first?.description || op.precedence == remainingOps.first?.precedence {
                            descStrLst.append("(\(binaryOperandFirst)" + symbol + "\(binaryOperandLast))")
                        } else {
                            descStrLst.append("\(binaryOperandFirst)" + symbol + "\(binaryOperandLast)")
                        }
                        return description(descStrLst, ops: remainingOps)
                    } else {
                        descStrLst.append("?" + symbol + "\(binaryOperandLast)")
                        return description(descStrLst, ops: remainingOps)
                    }
                } else {
                    descStrLst.append("?" + symbol + "?")
                    return description(descStrLst, ops: remainingOps)
                }
            }
        }
        return (descStrLst, ops)
    }
    
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op]) {
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op {
            case .Operand(let operand):
                return (operand, remainingOps)
            case .Variable(let symbol):
                if let variableValue = variableValues[symbol] {
                    return (variableValue, remainingOps)
                } else {
                    return (nil, remainingOps)
                }
                
            case .Pi(_, let piVal):
                return (piVal, remainingOps)
                
            case .UnaryOperation(_, let operation):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result {
                    return (operation(operand), operandEvaluation.remainingOps)
                } else {
                    error = "Missing unary operand"
                }
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result {
                        return (operation(operand1, operand2), op2Evaluation.remainingOps)
                    } else {
                        error = "Missing binary operand"
                    }
                } else {
                    error = "Missing binary operand"
                }
            }
        }
        return (nil, ops)
    }
    
    private func evaluate() -> Double? {
        let (result, _) = evaluate(opStack)
        return result
    }
    
    func evaluateAndReportErrors() -> CalculatorBrainEvaluationResult {
        if let evaluationResult = evaluate() {
            return CalculatorBrainEvaluationResult.Success(evaluationResult)
        } else {
            return CalculatorBrainEvaluationResult.Failure("Error")
        }
    }
    
    func clearStack() {
        opStack = [Op]()
    }
    
    func removeLastOpFromStack() {
        if opStack.last != nil {
            opStack.removeLast()
        }
    }
    
    func pushOperand(operand: Double) -> CalculatorBrainEvaluationResult? {
        opStack.append(Op.Operand(operand))
        return evaluateAndReportErrors()
    }
    
    func pushOperand(symbol: String) -> CalculatorBrainEvaluationResult? {
        opStack.append(Op.Variable(symbol))
        return evaluateAndReportErrors()
    }
    
    func pushConstant(symbol: String) -> CalculatorBrainEvaluationResult? {
        if let constant = knownOps[symbol] {
            opStack.append(constant)
        }        
        return evaluateAndReportErrors()
    }
    
    func performOperation(symbol: String) -> CalculatorBrainEvaluationResult? {
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
        return evaluateAndReportErrors()
    }
    
}