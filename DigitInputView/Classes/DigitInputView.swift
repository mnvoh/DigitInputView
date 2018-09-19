/**
 Copyright (c) 2017 Milad Nozari
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
*/

import UIKit

public enum DigitInputViewAnimationType: Int {
    case none, dissolve, spring
}

open class DigitInputView: UIView {
    
    open var delegate: DigitInputViewDelegate?
    
    /**
    The number of digits to show, which will be the maximum length of the final string
    */
    open var numberOfDigits: Int = 4 {
        
        didSet {
            setup()
        }
        
    }
    
    /**
    The color of the line under each digit
    */
    open var bottomBorderColor = UIColor.lightGray {
        
        didSet {
            setup()
        }
        
    }
    
    /**
     The color of the line under next digit
     */
    open var nextDigitBottomBorderColor = UIColor.gray {
        
        didSet {
            setup()
        }
        
    }
    
    /**
    The color of the digits
    */
    open var textColor: UIColor = .black {
        
        didSet {
            setup()
        }
        
    }
    
    /**
    If not nil, only the characters in this string are acceptable. The rest will be ignored.
    */
    open var acceptableCharacters: String? = nil
    
    /**
    The keyboard type that shows up when entering characters
    */
    open var keyboardType: UIKeyboardType = .default {
        
        didSet {
            setup()
        }
        
    }
    
    /**
     Keyboard appearance type. `default` or `light`, `dark` and `alert`.
    */
    open var keyboardAppearance: UIKeyboardAppearance = .default {
        
        didSet {
            setup()
        }
        
    }
    
    /// The animatino to use to show new digits
    open var animationType: DigitInputViewAnimationType = .spring
    
    /**
    The font of the digits. Although font size will be calculated automatically.
    */
    open var font: UIFont?
    
    /**
    The string that the user has entered
    */
    open var text: String {
        
        get {
            guard let textField = textField else { return "" }
            return textField.text ?? ""
        }
        
    }
    
    fileprivate var labels = [UILabel]()
    fileprivate var underlines = [UIView]()
    fileprivate var textField: UITextField?
    fileprivate var tapGestureRecognizer: UITapGestureRecognizer?
    
    fileprivate var underlineHeight: CGFloat = 4
    fileprivate var spacing: CGFloat = 8
    
    override open var canBecomeFirstResponder: Bool {
        
        get {
            return true
        }
        
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setup()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        setup()
        
    }
    
    override open func becomeFirstResponder() -> Bool {
        
        guard let textField = textField else { return false }
        textField.becomeFirstResponder()
        return true
        
    }
    
    override open func resignFirstResponder() -> Bool {
        
        guard let textField = textField else { return true }
        textField.resignFirstResponder()
        return true
        
    }
    
    override open func layoutSubviews() {
        
        super.layoutSubviews()
        
        // width to height ratio
        let ratio: CGFloat = 0.75
        
        // Now we find the optimal font size based on the view size
        // and set the frame for the labels
        var characterWidth = frame.height * ratio
        var characterHeight = frame.height
        
        // if using the current width, the digits go off the view, recalculate
        // based on width instead of height
        if (characterWidth + spacing) * CGFloat(numberOfDigits) + spacing > frame.width {
            characterWidth = (frame.width - spacing * CGFloat(numberOfDigits + 1)) / CGFloat(numberOfDigits)
            characterHeight = characterWidth / ratio
        }
        
        let extraSpace = frame.width - CGFloat(numberOfDigits - 1) * spacing - CGFloat(numberOfDigits) * characterWidth
        
        // font size should be less than the available vertical space
        let fontSize = characterHeight * 0.8
        
        let y = (frame.height - characterHeight) / 2
        for (index, label) in labels.enumerated() {
            let x = extraSpace / 2 + (characterWidth + spacing) * CGFloat(index)
            label.frame = CGRect(x: x, y: y, width: characterWidth, height: characterHeight)
            
            underlines[index].frame = CGRect(x: x, y: frame.height - underlineHeight, width: characterWidth, height: underlineHeight)
            
            if let font = font {
                label.font = font.withSize(fontSize)
            }
            else {
                label.font = label.font.withSize(fontSize)
            }
        }
        
    }
    
    /**
     Sets up the required views
     */
    fileprivate func setup() {
        
        isUserInteractionEnabled = true
        clipsToBounds = true
        
        if tapGestureRecognizer == nil {
            tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
            addGestureRecognizer(tapGestureRecognizer!)
        }
        
        if textField == nil {
            textField = UITextField()
            textField?.delegate = self
            textField?.frame = CGRect(x: 0, y: -40, width: 100, height: 30)
            addSubview(textField!)
        }
        
        textField?.keyboardType = keyboardType
        textField?.keyboardAppearance = keyboardAppearance
        
        // Since this function isn't called frequently, we just remove everything
        // and recreate them. Don't need to optimize it.
        
        for label in labels {
            label.removeFromSuperview()
        }
        labels.removeAll()
        
        for underline in underlines {
            underline.removeFromSuperview()
        }
        underlines.removeAll()
        
        for i in 0..<numberOfDigits {
            let label = UILabel()
            label.textAlignment = .center
            label.isUserInteractionEnabled = false
            label.textColor = textColor
            
            let underline = UIView()
            underline.backgroundColor = i == 0 ? nextDigitBottomBorderColor : bottomBorderColor
            
            addSubview(label)
            addSubview(underline)
            labels.append(label)
            underlines.append(underline)
        }
        
    }
    
    /**
     Handles tap gesture on the view
    */
    @objc fileprivate func viewTapped(_ sender: UITapGestureRecognizer) {
        
        textField!.becomeFirstResponder()
        
    }
    
    /**
     Called when the text changes so that the labels get updated
    */
    fileprivate func didChange(_ backspaced: Bool = false) {
        
        guard let textField = textField, let text = textField.text else { return }
        
        for item in labels {
            item.text = ""
        }
        
        for (index, item) in text.characters.enumerated() {
            if labels.count > index {
                let animate = index == text.characters.count - 1 && !backspaced
                changeText(of: labels[index], newText: String(item), animate)
            }
        }
        
        // set all the bottom borders color to default
        for underline in underlines {
            underline.backgroundColor = bottomBorderColor
        }
        
        let nextIndex = text.characters.count + 1
        if labels.count > 0, nextIndex < labels.count + 1 {
            // set the next digit bottom border color
            underlines[nextIndex - 1].backgroundColor = nextDigitBottomBorderColor
        }
        else {
            delegate?.endDigitInputView()
        }
        
    }
    
    /// Changes the text of a UILabel with animation
    ///
    /// - parameter label: The label to change text of
    /// - parameter newText: The new string for the label
    private func changeText(of label: UILabel, newText: String, _ animated: Bool = false) {
        
        if !animated || animationType == .none {
            label.text = newText
            return
        }
        
        if animationType == .spring {
            label.frame.origin.y = frame.height
            label.text = newText
            
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { 
                label.frame.origin.y = self.frame.height - label.frame.height
            }, completion: nil)
        }
        else if animationType == .dissolve {
            UIView.transition(with: label,
                              duration: 0.4,
                              options: .transitionCrossDissolve,
                              animations: {
                                label.text = newText
            }, completion: nil)
        }
    }
    
}


// MARK: TextField Delegate
extension DigitInputView: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let char = string.cString(using: .utf8)
        let isBackSpace = strcmp(char, "\\b")
        if isBackSpace == -92, let text = textField.text {
            textField.text = text.substring(to: text.index(text.endIndex, offsetBy: -1))
            didChange(true)
            return false
        }
        
        if textField.text?.characters.count ?? 0 >= numberOfDigits {
            return false
        }
        
        guard let acceptableCharacters = acceptableCharacters else {
            textField.text = (textField.text ?? "") + string
            didChange()
            return false
        }
        
        if acceptableCharacters.contains(string) {
            textField.text = (textField.text ?? "") + string
            didChange()
            return false
        }
        
        return false
        
    }
}

public protocol DigitInputViewDelegate {
    func endDigitInputView()
}
