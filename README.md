# DigitInputView

[![CI Status](http://img.shields.io/travis/mnvoh/DigitInputView.svg?style=flat)](https://travis-ci.org/mnvoh/DigitInputView)
[![Version](https://img.shields.io/cocoapods/v/DigitInputView.svg?style=flat)](http://cocoapods.org/pods/DigitInputView)
[![License](https://img.shields.io/cocoapods/l/DigitInputView.svg?style=flat)](http://cocoapods.org/pods/DigitInputView)
[![Platform](https://img.shields.io/cocoapods/p/DigitInputView.svg?style=flat)](http://cocoapods.org/pods/DigitInputView)

![DigitInputView](https://user-images.githubusercontent.com/4628766/28941699-0aba3938-78ae-11e7-8172-d0cf16dc5ecb.gif)

## Installation

DigitInputView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "DigitInputView"
```

Alternatively, you can simply copy `DigitInputView/Classes/DigitInputView.swift` into your project.

## Usage

You can customize the look and feel of the view according to the following code snippet.

```
digitInput = DigitInputView()
    
digitInput.numberOfDigits = 6
digitInput.bottomBorderColor = .purple
digitInput.nextDigitBottomBorderColor = .red
digitInput.textColor = .purple
digitInput.acceptableCharacters = "0123456789"
digitInput.keyboardType = .decimalPad
digitInput.font = UIFont.monospacedDigitSystemFont(ofSize: 10, weight: 1)
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Author

mnvoh, mnvoh90@gmail.com

## License

DigitInputView is available under the MIT license. See the LICENSE file for more info.
