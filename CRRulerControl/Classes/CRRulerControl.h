//
//  CRRulerControl.h
//  Pods
//
//  Created by Sergey Chuchukalo on 08/25/2016.
//
//  Copyright © 2016 Cleveroad Inc. All rights reserved.

#import <UIKit/UIKit.h>
#import "CRRulerLayer.h"

/**
 *   Customise ruler. Have action rulerValueChaned. Can change color and size all elements.
 */
IB_DESIGNABLE
@interface CRRulerControl : UIControl 

/**
 *  NS_OPTIONS of all marks on the ruller view.
 */
typedef NS_OPTIONS(NSUInteger, CRRulerMarkType) {
    /**
     *  Major mark
     */
    CRRulerMarkTypeMajor = 1 << 0,
    /**
     *  Middle mark
     */
    CRRulerMarkTypeMiddle = 1 << 1,
    /**
     *  Minor mark
     */
    CRRulerMarkTypeMinor = 1 << 2,
    /**
     *  Choose all marks
     */
    CRRulerMarkTypeAll = ~0UL,
};

@property (nonatomic, readonly) UIScrollView *scrollView;
/**
 *  ImageView on center controll default red line
 */
@property (nonatomic, readonly) UIImageView *pointerImageView;
/**
 *  Spacing between center of nearby marks
 */
@property (nonatomic) IBInspectable CGFloat spacingBetweenMarks;
/**
 *  All width of rulerControl default 1000
 */
@property (nonatomic) IBInspectable CGFloat rulerWidth;
/**
 *  Text value of left mark on rulerControl default - 10
 */
@property (nonatomic) IBInspectable CGFloat rangeFrom;
/**
 *  Length rulerControl beginning from rangeFrom default 20
 */
@property (nonatomic) IBInspectable CGFloat rangeLength;
/**
 *  Value on center of CRRulerControl. Thay variable by proterty rangeFrom and rangeLength default 0
 */
@property (nonatomic) IBInspectable CGFloat value;

/**
 *  Change value with animation or without it
 *
 *  @param Value Label beneath lines. Set by proterty rangeFrom and rangeLength. Have setter method.
 *  @param Animated BOOL parameters with show scroll animation or without it
 */
- (void)setValue:(CGFloat)value animated:(BOOL)animated;

/**
 *  Helper for choose position of ImageView on CRRulerControl
 *
 *  @return Return position of ImageView on X cordinate line
 */
- (CGRect)frameForPointerImageView;

/**
 *  Helper for set on scrollview some custom elements
 *
 *  @param Value Set by proterty rangeFrom and rangeLength
 *
 *  @return ContentOffset of scrollView where located mark with this value
 */
- (CGPoint)contentOffsetForValue:(CGFloat)value;


/**
 *  Change size of line mark
 *
 *  @param lineSize Size of line mark
 *  @param markType  NS_OPTIONS CRRulerMarkType.
 *                   CRRulerMarkTypeMajor for choose Major Mark default {1, 5}
 *                   CRRulerMarkTypeMiddle for choose Middle Mark default {1,10}
 *                   CRRulerMarkTypeMinor for choose Minor Mark default {2,20}
 *                   CRRulerMarkTypeAll for choose All Mark
 */
- (void)setSize:(CGSize)size forMarkType:(CRRulerMarkType)markType;

/**
 *  Change size of line mark
 *
 *  @param lineColor Color of line Mark default used tintColor of CRRulerControl
 *  @param markType  NS_OPTIONS CRRulerMarkType. 
 *                   CRRulerMarkTypeMajor for choose Major Mark
 *                   CRRulerMarkTypeMiddle for choose Middle Mark
 *                   CRRulerMarkTypeMinor for choose Minor Mark
 *                   CRRulerMarkTypeAll for choose All Mark
 *
 */
- (void)setColor:(UIColor *)color forMarkType:(CRRulerMarkType)markType;

/**
 *  Change text of line mark
 *
 *  @param lineColor Color of line Mark default used tintColor of CRRulerControl
 *  @param markType  NS_OPTIONS CRRulerMarkType.
 *                   CRRulerMarkTypeMajor for choose Major Mark
 *                   CRRulerMarkTypeMiddle for choose Middle Mark
 *                   CRRulerMarkTypeMinor for choose Minor Mark
 *                   CRRulerMarkTypeAll for choose All Mark
 */
- (void)setTextColor:(UIColor *)textColor forMarkType:(CRRulerMarkType)markType;

/**
 *  Change font of text mark
 *
 *  @param textFont  Font of text mark default Courier with size 10
 *  @param markType  NS_OPTIONS CRRulerMarkType.
 *                   CRRulerMarkTypeMajor for choose Major Mark
 *                   CRRulerMarkTypeMiddle for choose Middle Mark
 *                   CRRulerMarkTypeMinor for choose Minor Mark
 *                   CRRulerMarkTypeAll for choose All Mark
 */
- (void)setFont:(UIFont *)font forMarkType:(CRRulerMarkType)markType;

/**
 *  Change frequency of mark
 *
 *  @param Frequency of showing mark in CRRulerControl
 *  @param markType  NS_OPTIONS CRRulerMarkType.
 *                   CRRulerMarkTypeMajor for choose Major Mark default every 10 Mark (When set new value showing this
 *                   mark is = frequency this mark / frequency of minor mark. This Mark have a priority by middle mark 
 *                   and by minor mark. If this frequency <= of minor mark frequency, than you can not see this mark. (first set minor mark).
 *                   CRRulerMarkTypeMiddle for choose Middle Mark default every 5 Mark (When set new value showing this
 *                   mark is = frequency this mark / frequency of minor mark. This Mark have a priority by minor mark. 
 *                   If this frequency <= of minor mark frequency, than you can not see this mark. (first set minor mark).
 *                   CRRulerMarkTypeMinor for choose Minor Mark. if mark is not major of middle than they minor.
 *                   Thay can not be 0. Minor mark it is one step on CRRulerControl.
 *                   CRRulerMarkTypeAll for choose All Mark
 *
 *                   Count of marks = rangeLength / frequency of minor mark
 */
- (void)setFrequency:(CGFloat)frequency forMarkType:(CRRulerMarkType)markType;

/**
 *  Change alignment of text mark
 *
 *  @param alignment CRRulerMarkAlignment of text mark default bottom
 *                   CRRulerMarkAlignmentBottom,
 *                   CRRulerMarkAlignmentCenter,
 *                   CRRulerMarkAlignmentTop,
 *  @param markType  NS_OPTIONS CRRulerMarkType.
 *                   CRRulerMarkTypeMajor for choose Major Mark
 *                   CRRulerMarkTypeMiddle for choose Middle Mark
 *                   CRRulerMarkTypeMinor for choose Minor Mark
 *                   CRRulerMarkTypeAll for choose All Mark
 */
- (void)setTextAlignment:(CRRulerMarkAlignment)alignment forMarkType:(CRRulerMarkType)markType;

/**
 *  Change alignment of lines mark
 *
 *  @param alignment CRRulerMarkAlignment of line mark default center
 *                   CRRulerMarkAlignmentBottom,
 *                   CRRulerMarkAlignmentCenter,
 *                   CRRulerMarkAlignmentTop,
 *  @param markType  NS_OPTIONS CRRulerMarkType.
 *                   CRRulerMarkTypeMajor for choose Major Mark
 *                   CRRulerMarkTypeMiddle for choose Middle Mark
 *                   CRRulerMarkTypeMinor for choose Minor Mark
 *                   CRRulerMarkTypeAll for choose All Mark
 */
- (void)setAlignment:(CRRulerMarkAlignment)alignment forMarkType:(CRRulerMarkType)markType;

/**
 *  Change offset of text marks
 *
 *  @param textOffset CGPoint default {0.0}
 *  @param markType  NS_OPTIONS CRRulerMarkType.
 *                   CRRulerMarkTypeMajor for choose Major Mark
 *                   CRRulerMarkTypeMiddle for choose Middle Mark
 *                   CRRulerMarkTypeMinor for choose Minor Mark
 *                   CRRulerMarkTypeAll for choose All Mark
 */
- (void)setTextOffset:(CGPoint)textOffset forMarkType:(CRRulerMarkType)markType;

/**
 *  Change offset of lines marks
 *
 *  @param offset    CGPoint default {0.0}
 *  @param markType  NS_OPTIONS CRRulerMarkType.
 *                   CRRulerMarkTypeMajor for choose Major Mark
 *                   CRRulerMarkTypeMiddle for choose Middle Mark
 *                   CRRulerMarkTypeMinor for choose Minor Mark
 *                   CRRulerMarkTypeAll for choose All Mark
 */
- (void)setOffset:(CGPoint)offset forMarkType:(CRRulerMarkType)markType;

/**
 *  Return size of Mark
 *
 *  @param markType  NS_OPTIONS CRRulerMarkType.
 *                   CRRulerMarkTypeMajor for choose Major Mark
 *                   CRRulerMarkTypeMiddle for choose Middle Mark
 *                   CRRulerMarkTypeMinor for choose Minor Mark
 *                   CRRulerMarkTypeAll for choose All Mark
 *
 *  @return If choose CRRulerMarkTypeAll mark than return CGSizeZero
 */
- (CGSize)sizeForMarkType:(CRRulerMarkType)markType;
/**
 *  Return color of Mark
 *
 *  @param markType  NS_OPTIONS CRRulerMarkType.
 *                   CRRulerMarkTypeMajor for choose Major Mark
 *                   CRRulerMarkTypeMiddle for choose Middle Mark
 *                   CRRulerMarkTypeMinor for choose Minor Mark
 *                   CRRulerMarkTypeAll for choose All Mark
 *
 *  @return If choose CRRulerMarkTypeAll mark than return nil
 */
- (UIColor *)colorForMarkType:(CRRulerMarkType)markType;
/**
 *  Return text color of mark
 *
 *  @param markType  NS_OPTIONS CRRulerMarkType.
 *                   CRRulerMarkTypeMajor for choose Major Mark
 *                   CRRulerMarkTypeMiddle for choose Middle Mark
 *                   CRRulerMarkTypeMinor for choose Minor Mark
 *                   CRRulerMarkTypeAll for choose All Mark
 *
 *  @return If choose CRRulerMarkTypeAll mark than return nil
 */
- (UIColor *)textColorForMarkType:(CRRulerMarkType)markType;
/**
 *  Return font of mark
 *
 *  @param markType  NS_OPTIONS CRRulerMarkType.
 *                   CRRulerMarkTypeMajor for choose Major Mark
 *                   CRRulerMarkTypeMiddle for choose Middle Mark
 *                   CRRulerMarkTypeMinor for choose Minor Mark
 *                   CRRulerMarkTypeAll for choose All Mark
 *
 *  @return If choose CRRulerMarkTypeAll mark than return nil
 */
- (UIFont *)fontForMarkType:(CRRulerMarkType)markType;
/**
 *  Return frequency of mark
 *
 *  @param markType  NS_OPTIONS CRRulerMarkType.
 *                   CRRulerMarkTypeMajor for choose Major Mark
 *                   CRRulerMarkTypeMiddle for choose Middle Mark
 *                   CRRulerMarkTypeMinor for choose Minor Mark
 *                   CRRulerMarkTypeAll for choose All Mark
 *
 *  @return If choose CRRulerMarkTypeAll mark than return CGSizeZero
 */
- (CGFloat)frequencyForMarkType:(CRRulerMarkType)markType;

/**
 *  Return alignment of text mark
 *
 *  @param markType  NS_OPTIONS CRRulerMarkType.
 *                   CRRulerMarkTypeMajor for choose Major Mark
 *                   CRRulerMarkTypeMiddle for choose Middle Mark
 *                   CRRulerMarkTypeMinor for choose Minor Mark
 *                   CRRulerMarkTypeAll for choose All Mark
 *
 *  @return alignment CRRulerMarkAlignment
 *                   CRRulerMarkAlignmentBottom,
 *                   CRRulerMarkAlignmentCenter,
 *                   CRRulerMarkAlignmentTop,
 */
- (CRRulerMarkAlignment)textAlignmentForMarkType:(CRRulerMarkType)markType;

/**
 *  Return alignment of line mark
 *
 *  @param markType  NS_OPTIONS CRRulerMarkType.
 *                   CRRulerMarkTypeMajor for choose Major Mark
 *                   CRRulerMarkTypeMiddle for choose Middle Mark
 *                   CRRulerMarkTypeMinor for choose Minor Mark
 *                   CRRulerMarkTypeAll for choose All Mark
 *
 *  @return alignment CRRulerMarkAlignment
 *                   CRRulerMarkAlignmentBottom,
 *                   CRRulerMarkAlignmentCenter,
 *                   CRRulerMarkAlignmentTop,
 */
- (CRRulerMarkAlignment)alignmentForMarkType:(CRRulerMarkType)markType;

/**
 *  Return offset of text mark
 *
 *  @param markType  NS_OPTIONS CRRulerMarkType.
 *                   CRRulerMarkTypeMajor for choose Major Mark
 *                   CRRulerMarkTypeMiddle for choose Middle Mark
 *                   CRRulerMarkTypeMinor for choose Minor Mark
 *                   CRRulerMarkTypeAll for choose All Mark
 *
 *  @return alignment CRRulerMarkAlignment
 *                   CRRulerMarkAlignmentBottom,
 *                   CRRulerMarkAlignmentCenter,
 *                   CRRulerMarkAlignmentTop,
 */
- (CGPoint)textOffsetForMarkType:(CRRulerMarkType)markType;

/**
 *  Return offset of line mark
 *
 *  @param markType  NS_OPTIONS CRRulerMarkType.
 *                   CRRulerMarkTypeMajor for choose Major Mark
 *                   CRRulerMarkTypeMiddle for choose Middle Mark
 *                   CRRulerMarkTypeMinor for choose Minor Mark
 *                   CRRulerMarkTypeAll for choose All Mark
 *
 *  @return alignment CRRulerMarkAlignment
 *                   CRRulerMarkAlignmentBottom,
 *                   CRRulerMarkAlignmentCenter,
 *                   CRRulerMarkAlignmentTop,
 */
- (CGPoint)offsetForMarkType:(CRRulerMarkType)markType;

@end