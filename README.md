# CRRulerControl [![Awesome](https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg)](https://github.com/sindresorhus/awesome) <img src="https://www.cleveroad.com/public/comercial/label-ios.svg" height="20"> <a href="https://www.cleveroad.com/?utm_source=github&utm_medium=label&utm_campaign=contacts"><img src="https://www.cleveroad.com/public/comercial/label-cleveroad.svg" height="20"></a>

[![CI Status](http://img.shields.io/travis/Sergey/CRRulerControl.svg?style=flat)](https://travis-ci.org/Sergey/CRRulerControl) [![Version](https://img.shields.io/cocoapods/v/CRRulerControl.svg?style=flat)](http://cocoapods.org/pods/CRRulerControl) [![License](https://img.shields.io/cocoapods/l/CRRulerControl.svg?style=flat)](http://cocoapods.org/pods/CRRulerControl) [![Platform](https://img.shields.io/cocoapods/p/CRRulerControl.svg?style=flat)](http://cocoapods.org/pods/CRRulerControl)

![Header image](/images/header.jpg)

## Meet CRRulerControl - Customizable Control for iOS

Cleveroad is happy to present a new library for iOS apps — CRRulerControl. Whether your app is going to operate over graphics or any scalable elements, ruler is crucial to provide users convenience and enhance their experience. Customizable component, created by Cleveroad iOS developers, is aimed at turning a simple ruler into a handy and smart instrument.

![Demo image](/images/demo.gif)

#####Check out the animation of <strong><a target="_blank" href="https://www.youtube.com/watch?v=PdEucF-YDjo">CRRulerControl for iOS on YouTube</a></strong> in HD quality.

If you are ready to take a fresh look at traditional control elements, start with the Ruler. Integrate your iOS app with CRRulerControl library and try out all the benefits it provides.


[![Awesome](/images/logo-footer.png)](https://www.cleveroad.com/?utm_source=github&utm_medium=label&utm_campaign=contacts)
<br/>

A CocoaPod that simplifies the process of setting and reading values from the ruler.

Creating control elements is rather a simple task. However, it may take fairly large amount of time. To save this time, Cleveroad has created one of the control elements called CRRulerControl. CRRulerControl is a UIControl that can adjust to any your requirements in just a few seconds.

## Requirements
* iOS 8 or higher

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

CRRulerControl is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "CRRulerControl"
```
and run pod install in terminal.
Usage

## CRRulerControl
####You can use storyboard to create a control element. 

```objective-c
//Setting the distance between the minimal marks.
- @property (nonatomic) IBInspectable CGFloat spacingBetweenMarks; 

//Setting ruler width 
- @property (nonatomic) IBInspectable CGFloat rulerWidth; 

//Setting the minimum value
- @property (nonatomic) IBInspectable CGFloat rangeFrom; 

//Setting the length of liner
- @property (nonatomic) IBInspectable CGFloat rangeLength; 

//Setting value.
- @property (nonatomic) IBInspectable CGFloat value; 

//Setting image of pointer 
- @property (nonatomic, readonly) UIImageView *pointerImageView; 

- @property (nonatomic, readonly) UIScrollView *scrollView; 

//Setting with animation or without it. 
- (void)setValue:(CGFloat)value animated:(BOOL)animated; 

- (CGRect)frameForPointerImageView; 

- (CGPoint)contentOffsetForValue:(CGFloat)value; 

//To set the size of the lines
- (void)setSize:(CGSize)size forMarkType:(CRRulerMarkType)markType; 

//To set the color of the lines
- (void)setColor:(UIColor *)color forMarkType:(CRRulerMarkType)markType; 

//To set the text of the lines
- (void)setTextColor:(UIColor *)textColor forMarkType:(CRRulerMarkType)markType; 

//To set the font to the text
- (void)setFont:(UIFont *)font forMarkType:(CRRulerMarkType)markType; 

//To set the frequency of lines appearance
- (void)setFrequency:(CGFloat)frequency forMarkType:(CRRulerMarkType)markType; 
```
## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Support

If you have any other questions regarding the use of this library, please contact us for support at info@cleveroad.com (email subject: "CRRulerControl. Support request.") 

## Author

[Sergey Chuchukalo](Chuchukalo.cr@gmail.com)

## License

The MIT License (MIT)

Copyright (c) 2016 Cleveroad Inc.

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
