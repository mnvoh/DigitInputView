//
//  ViewController.swift
//  DigitInputView
//
//  Created by mnvoh on 07/20/2017.
//  Copyright (c) 2017 mnvoh. All rights reserved.
//

import UIKit
import DigitInputView

class ViewController: UIViewController, DigitInputViewDelegate {

    var digitInput: DigitInputView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        digitInput = DigitInputView()
        
        digitInput.numberOfDigits = 6
        digitInput.bottomBorderColor = .purple
        digitInput.nextDigitBottomBorderColor = .red
        digitInput.textColor = .purple
        digitInput.acceptableCharacters = "0123456789"
        digitInput.keyboardType = .decimalPad
        digitInput.font = UIFont.monospacedDigitSystemFont(ofSize: 10, weight: UIFont.Weight(rawValue: 1))
        digitInput.animationType = .spring
        digitInput.keyboardAppearance = .dark
        
        digitInput.delegate = self
        
        // if you wanna use layout constraints
        digitInput.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(digitInput)
        
        digitInput.topAnchor.constraint(equalTo: view.topAnchor, constant: 96).isActive = true
        digitInput.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32).isActive = true
        digitInput.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32).isActive = true
        digitInput.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        _ = digitInput.becomeFirstResponder()
    }
    
    func digitInputView(_ digitInputView: DigitInputView, didFinishWithCode code: String) {
        _ = digitInput.resignFirstResponder()
        print(digitInput.text)
    }
}

