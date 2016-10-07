//
//  CRRulerLayer.m
//  Pods
//
//  Created by Sergey Chuchukalo on 08/25/2016.
//
//  Copyright © 2016 Cleveroad Inc. All rights reserved.

#import "CRRulerLayer.h"

static const CGFloat kScreenSeparatorPositionToTextAndLines = 0.66;
static const CGFloat kDefaultFrequencyForMajorMark = 10;
static const CGFloat kDefaultFrequencyForMiddleMark = 5;
static const CGFloat kSideOffset = 30.0;
static const CGSize  kMiddleMarkSize = {1, 15};
static const CGSize  kMajorMarkSize = {1, 30};

@implementation CRRulerLayer

// in init code init and set default value for different style of marks
- (instancetype)init {
    if (self = [super init]) {
        self.minorMark = [CRMark new];
        self.minorMark.textColor = [UIColor clearColor];                // set default text color
        self.middleMark = [CRMark new];
        self.middleMark.frequency = kDefaultFrequencyForMiddleMark;     // set default frequency
        self.middleMark.size = kMiddleMarkSize;                         // set dafault size
        self.majorMark = [CRMark new];
        self.majorMark.frequency = kDefaultFrequencyForMajorMark;       // set default frequency
        self.majorMark.size = kMajorMarkSize;                           // set dafault size
    }
    return self;
}

// setters where code checking valid value
- (void)setRulerRange:(CRRange)rulerRange {
    _rulerRange = rulerRange;
    if (rulerRange.length > 0.0) {
        [self setNeedsDisplay];
    }
}
- (void)setFrame:(CGRect)frame {
    if (!CGRectEqualToRect(frame, self.frame)) {
        super.frame = frame;
        [self setNeedsDisplay];
    }
}

// in drawToImage code set position where need draw marks
- (void)drawToImage {
    NSUInteger numberOfLines = ceilf(self.rulerRange.length / [NSNumber numberWithFloat:self.minorMark.frequency].doubleValue);
    NSUInteger numberOfLinesToZeroForMajor;
    NSUInteger numberOfLinesToZeroForMiddle;
    if (self.rulerRange.location >= 0) {
        numberOfLinesToZeroForMajor = self.rulerRange.location / [NSNumber numberWithFloat:self.minorMark.frequency].doubleValue;
        numberOfLinesToZeroForMiddle = self.rulerRange.location / [NSNumber numberWithFloat:self.minorMark.frequency].doubleValue;
    } else {
        numberOfLinesToZeroForMajor = ceilf((-self.rulerRange.location * self.majorMark.frequency + self.rulerRange.location) / [NSNumber numberWithFloat:self.minorMark.frequency].doubleValue);
        numberOfLinesToZeroForMiddle = ceilf((-self.rulerRange.location * self.middleMark.frequency + self.rulerRange.location) / [NSNumber numberWithFloat:self.minorMark.frequency].doubleValue);
    }
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, [UIScreen mainScreen].scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGFloat lineOffset = (self.frame.size.width - kSideOffset * 2) / numberOfLines;
    NSMutableArray *arrayWithTypeMarks = [NSMutableArray arrayWithCapacity:numberOfLines];
    NSNumberFormatter *textMarkFormater = [NSNumberFormatter new];
    textMarkFormater.numberStyle = NSNumberFormatterDecimalStyle;
    textMarkFormater.maximumFractionDigits = 2;
    for (int i = 0; i <= numberOfLines; i++) {
        arrayWithTypeMarks[i] = self.minorMark;
        if ([NSNumber numberWithFloat:self.middleMark.frequency].integerValue != 0) {
            if ((i + numberOfLinesToZeroForMiddle) % [NSNumber numberWithFloat:self.middleMark.frequency].integerValue == 0) {
                arrayWithTypeMarks[i] = self.middleMark;
            }
        }
        if ([NSNumber numberWithFloat:self.majorMark.frequency].integerValue != 0) {
            if ((i + numberOfLinesToZeroForMajor) % [NSNumber numberWithFloat:self.majorMark.frequency].integerValue == 0) {
                arrayWithTypeMarks[i] = self.majorMark;
            }
        }
    }
    for (int i = 0; i <= numberOfLines; i++) {
        CGFloat num = self.rulerRange.location + (self.minorMark.frequency * i);
        NSString * numStr = [textMarkFormater stringFromNumber:[NSNumber numberWithFloat:num]];
        CGFloat position = i * lineOffset;
        [self drawMarkInContext:ctx position:position text:numStr mark:arrayWithTypeMarks[i]];
    }
    UIImage *imageToDraw = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [imageToDraw imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    self.contents = (id)imageToDraw.CGImage;
}

// in drawMarkInContext:position:text:mark code draw lines marks and text marks on position with text
// and style (color of text; color of lines; font of text; size of lines
- (void)drawMarkInContext:(CGContextRef)ctx position:(CGFloat)position text:(NSString *)text mark:(CRMark *)mark {   
    NSDictionary *attributes = @{ NSFontAttributeName: mark.font, NSForegroundColorAttributeName: mark.textColor};
    CGSize textSize = [text sizeWithAttributes:attributes];
    
    CGFloat rectX = position + kSideOffset - mark.size.width / 2 + mark.offset.x;
    CGFloat rectY;
    if (mark.alignment == CRRulerMarkAlignmentCenter) {
        rectY = (self.frame.size.height - mark.size.height) / 2;
    }
    if (mark.alignment == CRRulerMarkAlignmentBottom) {
        rectY = self.frame.size.height - mark.size.height - textSize.height;
    }
    if (mark.alignment == CRRulerMarkAlignmentTop) {
        rectY = textSize.height;
    }
    rectY += mark.offset.y;
    CGRect rect = CGRectMake(rectX, rectY, mark.size.width, mark.size.height);
    CGContextSetFillColorWithColor(ctx, mark.color.CGColor);
    CGContextFillRect(ctx, rect);
    
    CGFloat textRectX = position + kSideOffset - textSize.width / 2 + mark.textOffset.x;
    CGFloat textRectY;
    if (mark.textAlignment == CRRulerMarkAlignmentCenter) {
        textRectY = (self.frame.size.height - textSize.height) / 2 ;
    }
    if (mark.textAlignment == CRRulerMarkAlignmentBottom) {
        textRectY = self.frame.size.height - textSize.height;
    }
    if (mark.textAlignment == CRRulerMarkAlignmentTop) {
        textRectY = 0;
    }
    textRectY += mark.textOffset.y;
    CGRect textRect = CGRectMake(textRectX, textRectY, textSize.width, textSize.height);
    [text drawInRect:textRect withAttributes:attributes];
}

#pragma mark - Display

- (void)display {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [self drawToImage];
    [CATransaction commit];
}

@end