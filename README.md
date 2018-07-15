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
digitInput.animationType = .spring
digitInput.keyboardAppearance = .dark
```

## Options
### numberOfDigits
The number of digits (characters) to show

Type: `Int`

Default: `4`

### bottomBorderColor
The color of the line under digits

Type: `UIColor`

Default: `UIColor.lightGray`

### nextDigitBottomBorderColor
The color of the line under the digit that the user is about to input

Type: `UIColor`

Default: `UIColor.gray`

### textColor
The color of the text

Type: `UIColor`

Default: `UIColor.black`

### acceptableCharacters
If set, only the characters in this string are accepted. Anything else will be ignored.

Type: `String?`

Default: `nil`

### keyboardType
The type of the keyboard to show to the user.

Type: `UIKeyboardType`

Default: `UIKeyboardType.default`

Values:


```
public enum UIKeyboardType : Int {

    
    case `default` // Default type for the current input method.

    case asciiCapable // Displays a keyboard which can enter ASCII characters

    case numbersAndPunctuation // Numbers and assorted punctuation.

    case URL // A type optimized for URL entry (shows . / .com prominently).

    case numberPad // A number pad with locale-appropriate digits (0-9, ۰-۹, ०-९, etc.). Suitable for PIN entry.

    case phonePad // A phone pad (1-9, *, 0, #, with letters under the numbers).

    case namePhonePad // A type optimized for entering a person's name or phone number.

    case emailAddress // A type optimized for multiple email address entry (shows space @ . prominently).

    @available(iOS 4.1, *)
    case decimalPad // A number pad with a decimal point.

    @available(iOS 5.0, *)
    case twitter // A type optimized for twitter text entry (easy access to @ #)

    @available(iOS 7.0, *)
    case webSearch // A default keyboard type with URL-oriented addition (shows space . prominently).

    @available(iOS 10.0, *)
    case asciiCapableNumberPad // A number pad (0-9) that will always be ASCII digits.

    
    public static var alphabet: UIKeyboardType { get } // Deprecated
}

```

### animationType

The type of animation to use when showing a new digit (on being entered by the user)

Type: `DigitInputViewAnimationType`

Default: `.spring`

Values:

```

public enum DigitInputViewAnimationType: Int {
    case none, dissolve, spring
}

```

### font

The font to be used with labels.

Type: `UIFont?`

Default: `nil` (Default System Font)

### keyboardAppearance

Option to choose the keyboard's appearance. Possible values are:

`default`: This value is mapped to `light`

`dark`: Choose a dark keyboard

`light`: Choose a light keyboard

`alert`: An appearance appropriate for alert dialogs



## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Author

mnvoh, mnvoh90@gmail.com

## License

DigitInputView is available under the MIT license. See the LICENSE file for more info.
