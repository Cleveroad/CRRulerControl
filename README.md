# CRRulerControl [![Awesome](https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg)](https://github.com/sindresorhus/awesome) <img src="https://www.cleveroad.com/public/comercial/label-ios.svg" height="20"> <a href="https://www.cleveroad.com/?utm_source=github&utm_medium=label&utm_campaign=contacts"><img src="https://www.cleveroad.com/public/comercial/label-cleveroad.svg" height="20"></a>

[![CI Status](http://img.shields.io/travis/Sergey/CRRulerControl.svg?style=flat)](https://travis-ci.org/Sergey/CRRulerControl) [![Version](https://img.shields.io/cocoapods/v/CRRulerControl.svg?style=flat)](http://cocoapods.org/pods/CRRulerControl) [![License](https://img.shields.io/cocoapods/l/CRRulerControl.svg?style=flat)](http://cocoapods.org/pods/CRRulerControl) [![Platform](https://img.shields.io/cocoapods/p/CRRulerControl.svg?style=flat)](http://cocoapods.org/pods/CRRulerControl)

![Header image](/images/header.jpg)

## Meet CRRulerControl - Customizable Control Element for iOS

Cleveroad is happy to present a new library for iOS apps — CRRulerControl. Whether your app is going to operate over graphics or any scalable elements, ruler is crucial to provide users convenience and enhance their experience. Customizable component, created by Cleveroad iOS developers, is aimed at turning a simple ruler into a handy and smart instrument.

![Demo image](/images/demo.gif)

#####Check out the animation of <strong><a target="_blank" href="https://www.youtube.com/watch?v=PdEucF-YDjo">CRRulerControl for iOS on YouTube</a></strong> in HD quality.

If you are ready to take a fresh look at traditional control elements, start with the Ruler. Integrate your iOS app with CRRulerControl library and try out all the benefits it provides.


[![Awesome](/images/logo-footer.png)](https://www.cleveroad.com/?utm_source=github&utm_medium=label&utm_campaign=contacts)
<br/>

A CocoaPod that simplifies the process of setting and reading values from the ruler. Supplied with UIControl subclass.

Creating control elements is rather a simple task. However, it may take fairly large amount of time. To save this time, Cleveroad has created one of the control elements called CRRulerControl. CRRulerControl is a ruler that can adjust to any your requirements in just a few seconds.

## Requirements
* iOS 8 or higher

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

CRRulerControl is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```
pod "CRRulerControl"
```
and run pod install in terminal.
Usage

## CRRulerControl
####You can use storyboard to create a control element. 
####Using IBOutlet
```c
//That will be called when user changes value.
- (IBAction)rulerValueChaned:(CRRulerControl *)sender;

//To set the ruler length at a distance of two minimal marks.
//Priority value to the total length rulerWidth.
//Can be set using storyboard. 
- @property (nonatomic) IBInspectable CGFloat spacingBetweenMarks; 

//To set the length of the element that scrolls using storyboard. 
- @property (nonatomic) IBInspectable CGFloat rulerWidth; 

//To set the initial value in the leftmost point using storyboard.
- @property (nonatomic) IBInspectable CGFloat rangeFrom; 

//To set the length of the ruler in value from the left border to the right one using storyboard.
- @property (nonatomic) IBInspectable CGFloat rangeLength; 

//To set the initial value using storyboard.
- @property (nonatomic) IBInspectable CGFloat value; 

//To set any image and change a pointing element. 
- @property (nonatomic, readonly) UIImageView *pointerImageView; 

//To add some other elements over the ruler. 
- @property (nonatomic, readonly) UIScrollView *scrollView; 

//To change value with animation or without it. 
- (void)setValue:(CGFloat)value animated:(BOOL)animated; 

//To create the successor from CRRulerControl and redefine the position pointing element.
- (CGRect)frameForPointerImageView; 

//To find out contentOffset of scrollView by value on CRRulerControl
- (CGPoint)contentOffsetForValue:(CGFloat)value; 

//To set the size of the lines for one of the three types of Marks (Major, Middle,Minor)
- (void)setSize:(CGSize)size forMarkType:(CRRulerMarkType)markType; 

//To set the color of the lines for one of the three types of Marks (Major, Middle,Minor)
- (void)setColor:(UIColor *)color forMarkType:(CRRulerMarkType)markType; 

//To set the text of the lines for one of the three types of Marks (Major, Middle,Minor)
- (void)setTextColor:(UIColor *)textColor forMarkType:(CRRulerMarkType)markType; 

//To set the font to the text of the lines for one of the three types of Marks (Major, Middle,Minor)
- (void)setFont:(UIFont *)font forMarkType:(CRRulerMarkType)markType; 

//To set the frequency of lines appearance of one of the three types of Marks (Major, Middle,Minor). The frequency is entered to value and should be a multiple of the Minor frequency.
- (void)setFrequency:(CGFloat)frequency forMarkType:(CRRulerMarkType)markType; 
```
####Custom particle images

- Use images with transparent background;
- You can put an image on the pointing element
- You can add an image to any point of the line knowing the value of this point

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
