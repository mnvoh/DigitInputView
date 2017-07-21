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

open class DigitInputView: UIView {
    
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
    open var bottomBorderColor = UIColor.gray {
        
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
    fileprivate var textField: UITextField?
    fileprivate var tapGestureRecognizer: UITapGestureRecognizer?
    
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
        
        // Since this function isn't called frequently, we just remove everything
        // and recreate them. Don't need to optimize it.
        
        for label in labels {
            label.removeFromSuperview()
        }
        labels.removeAll()
        
        for _ in 0..<numberOfDigits {
            let label = UILabel()
            label.textAlignment = .center
            label.isUserInteractionEnabled = false
            label.textColor = textColor
            
            let border = UIView()
            border.backgroundColor = bottomBorderColor
            border.translatesAutoresizingMaskIntoConstraints = false
            
            label.addSubview(border)
            
            border.leftAnchor.constraint(equalTo: label.leftAnchor).isActive = true
            border.bottomAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
            border.rightAnchor.constraint(equalTo: label.rightAnchor).isActive = true
            border.heightAnchor.constraint(equalToConstant: 2).isActive = true
            
            addSubview(label)
            labels.append(label)
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
    fileprivate func didChange() {
        
        guard let textField = textField, let text = textField.text else { return }
        
        for item in labels {
            item.text = ""
        }
        
        for (index, item) in text.characters.enumerated() {
            if labels.count > index {
                labels[index].text = String(item)
            }
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
            didChange()
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
