//
//  CRRulerControl.m
//  Pods
//
//  Created by Sergey Chuchukalo on 08/25/2016.
//
//  Copyright © 2016 Cleveroad Inc. All rights reserved.

#import "CRRulerControl.h"

static const CGFloat kDefaultRulerWidth = 500;
static const CGFloat kDefaultRangeFrom = -10;
static const CGFloat kDefaultRangeLength = 20;
static const CGFloat kSideOffset = 30.0;
static const CGSize  kPointerImageViewSize = {2, 30};


@interface CRRulerControl () <UIScrollViewDelegate>

@property (nonatomic) CRRange rulerRange;
@property (nonatomic) CRRulerLayer *rulerLayer;
@property (nonatomic, readwrite) UIScrollView *scrollView;
@property (nonatomic, readwrite) UIImageView *pointerImageView;
@property (nonatomic, assign) BOOL isSetValued;
@end

@implementation CRRulerControl

#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _setupDefaultValues];
        [self _commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self _setupDefaultValues];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    if (_spacingBetweenMarks > 0 ) {
        self.rulerWidth = _spacingBetweenMarks * _rangeLength;
    }
    [self _commonInit];
}

- (void)_commonInit {
    [self setupScrollView];
    [self setupRulerLayer];
    [self setupPointerImage];
}

- (void)_setupDefaultValues {
    _rangeFrom = kDefaultRangeFrom;
    _rangeLength = kDefaultRangeLength;
    _rulerWidth = kDefaultRulerWidth;
}

#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat value = self.value;
    CGFloat sideInset = CGRectGetWidth(self.scrollView.frame) / 2.0f;
    self.scrollView.contentInset = UIEdgeInsetsMake(0, sideInset - kSideOffset, 0, sideInset - kSideOffset);
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.rulerLayer.frame = [self frameForRulerLayer];
    [CATransaction commit];
    [self.scrollView setContentSize:CGSizeMake(self.rulerWidth, self.frame.size.height)];
    self.scrollView.contentOffset = [self contentOffsetForValue:value];
    self.pointerImageView.frame = [self frameForPointerImageView];
}

#pragma mark - Frame

- (CGRect)frameForPointerImageView {
    CGFloat pointerImageViewOriginX = (self.frame.size.width - kPointerImageViewSize.width) / 2;
    CGFloat pointerImageViewOriginY = (self.frame.size.height - kPointerImageViewSize.height) / 2;
    CGRect rulerCenterViewRect = CGRectMake(pointerImageViewOriginX, pointerImageViewOriginY,
                                            kPointerImageViewSize.width, kPointerImageViewSize.height);
    return rulerCenterViewRect;
}

- (CGRect)frameForRulerLayer {
    return CGRectMake(0, 0, self.rulerWidth, self.frame.size.height);
}

#pragma mark - Setups

- (void)setupPointerImage {
    self.pointerImageView = [[UIImageView alloc] init];
    self.pointerImageView.backgroundColor = self.tintColor;
    [self addSubview:self.pointerImageView];
}

- (void)setupScrollView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = YES;
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.scrollView.delegate = self;
    self.scrollView.bounces = NO;
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self addSubview:self.scrollView];
}

- (void)setupRulerLayer {
    CRRange range;
    range.location = self.rangeFrom;
    range.length =  self.rangeLength;
    self.rulerRange = range;
    self.rulerLayer = [CRRulerLayer new];
    self.rulerLayer.rulerRange = self.rulerRange;
    self.rulerLayer.backgroundColor = [UIColor clearColor].CGColor;
    [self setColor:self.tintColor forMarkType:CRRulerMarkTypeAll];
    [self setTextColor:self.tintColor forMarkType:CRRulerMarkTypeMiddle | CRRulerMarkTypeMajor];
    [self.scrollView.layer addSublayer:self.rulerLayer];
}

#pragma mark - ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat oldValue = _value;
    if (_isSetValued) {
        _value = [self valueForContentOffset:[self contentOffsetForValue:_value]];
        _isSetValued = false;
    }else{
        _value = [self valueForContentOffset:scrollView.contentOffset];
    }
    if (oldValue != _value) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGFloat value = [self valueForContentOffset:*targetContentOffset];
    value = lroundf(value / self.rulerLayer.minorMark.frequency) * self.rulerLayer.minorMark.frequency;
    targetContentOffset->x = [self contentOffsetForValue:value].x;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat oldValue = [self valueForContentOffset:scrollView.contentOffset];
    _value = lroundf(oldValue / self.rulerLayer.minorMark.frequency) * self.rulerLayer.minorMark.frequency;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

#pragma mark - Helper for scroll

- (CGPoint)contentOffsetForValue:(CGFloat)value {
    CGFloat contentOffsetY = (value - self.rulerRange.location) * [self offsetCoefficient] - self.scrollView.contentInset.left;
    return CGPointMake(contentOffsetY, self.scrollView.contentOffset.y);
}

- (CGFloat)valueForContentOffset:(CGPoint)contentOffset {
    return self.rulerRange.location + (contentOffset.x + self.scrollView.contentInset.left) / [self offsetCoefficient];
}

- (CGFloat)offsetCoefficient {
    CGFloat distance = self.rulerRange.length;
    return (self.scrollView.contentSize.width - kSideOffset * 2) / distance;
}

#pragma mark - User interaction

- (void)tintColorDidChange {
//    [self setColor:self.tintColor forMarkType:CRRulerMarkTypeAll];
//    [self setTextColor:self.tintColor forMarkType:CRRulerMarkTypeMiddle | CRRulerMarkTypeMajor];
//    self.pointerImageView.backgroundColor = self.tintColor;
}

#pragma mark - Setters

- (void)setRangeFrom:(CGFloat)rangeFrom {
    _rangeFrom = rangeFrom;
    [self setRange];
}

- (void)setRangeLength:(CGFloat)rangeLength {
    _rangeLength = rangeLength;
    [self setRange];
}

- (void)setRange {
    CRRange range;
    range.location = self.rangeFrom;
    range.length =  self.rangeLength;
    self.rulerRange = range;
    self.rulerLayer.rulerRange = range;
    [self.rulerLayer setNeedsDisplay];
}

- (void)setSpacingBetweenMarks:(CGFloat)spacingBetweenMarks {
    _spacingBetweenMarks = spacingBetweenMarks;
    if (_spacingBetweenMarks >= 1 ) {
        if (self.rulerLayer.minorMark.frequency > 0) {
            self.rulerWidth = _spacingBetweenMarks * _rangeLength / self.rulerLayer.minorMark.frequency;
        } else {
            self.rulerWidth = _spacingBetweenMarks * _rangeLength;
        }
    }
}

- (void)setRulerWidth:(CGFloat)rulerWidth {
    if ((_rulerWidth != rulerWidth) && (rulerWidth <= 7000) && (rulerWidth > 0)) {
        _rulerWidth = rulerWidth;
        [self setNeedsLayout];
    }
}

- (void)setValue:(CGFloat)value {
    [self setValue:value animated:NO];
}

- (void)setValue:(CGFloat)value animated:(BOOL)animated {
    _value = value;
    _isSetValued = true;
    [self.scrollView setContentOffset:[self contentOffsetForValue:value] animated:animated];
}

#pragma mark - Change mark type method

- (void)setSize:(CGSize)size forMarkType:(CRRulerMarkType)markType {
    if (markType & CRRulerMarkTypeMajor) {
        self.rulerLayer.majorMark.size = size;
    }
    if (markType & CRRulerMarkTypeMiddle) {
        self.rulerLayer.middleMark.size = size;
    }
    if (markType & CRRulerMarkTypeMinor) {
        self.rulerLayer.minorMark.size = size;
    }
    [self.rulerLayer setNeedsDisplay];
}

- (void)setColor:(UIColor *)color forMarkType:(CRRulerMarkType)markType {
    if (markType & CRRulerMarkTypeMajor) {
        self.rulerLayer.majorMark.color = color;
    }
    if (markType & CRRulerMarkTypeMiddle) {
        self.rulerLayer.middleMark.color = color;
    }
    if (markType & CRRulerMarkTypeMinor) {
        self.rulerLayer.minorMark.color = color;
    }
    [self.rulerLayer setNeedsDisplay];
}

- (void)setTextColor:(UIColor *)textColor forMarkType:(CRRulerMarkType)markType {
    if (markType & CRRulerMarkTypeMajor) {
        self.rulerLayer.majorMark.textColor = textColor;
    }
    if (markType & CRRulerMarkTypeMiddle) {
        self.rulerLayer.middleMark.textColor = textColor;
    }
    if (markType & CRRulerMarkTypeMinor) {
        self.rulerLayer.minorMark.textColor = textColor;
    }
    [self.rulerLayer setNeedsDisplay];
}

- (void)setFont:(UIFont *)font forMarkType:(CRRulerMarkType)markType {
    if (markType & CRRulerMarkTypeMajor) {
        self.rulerLayer.majorMark.font = font;
    }
    if (markType & CRRulerMarkTypeMiddle) {
        self.rulerLayer.middleMark.font = font;
    }
    if (markType & CRRulerMarkTypeMinor) {
        self.rulerLayer.minorMark.font = font;
    }
    [self.rulerLayer setNeedsDisplay];
}

- (void)setFrequency:(CGFloat)frequency forMarkType:(CRRulerMarkType)markType {
    if (markType & CRRulerMarkTypeMajor) {
        if (self.rulerLayer.minorMark.frequency < frequency) {
            self.rulerLayer.majorMark.frequency = frequency / [NSNumber numberWithFloat:self.rulerLayer.minorMark.frequency].floatValue;
        } else {
            self.rulerLayer.majorMark.frequency = 0;
        }
    }
    if (markType & CRRulerMarkTypeMiddle) {
        if (self.rulerLayer.minorMark.frequency < frequency) {
            self.rulerLayer.middleMark.frequency = frequency / [NSNumber numberWithFloat:self.rulerLayer.minorMark.frequency].floatValue;
        } else {
            self.rulerLayer.middleMark.frequency = 0;
        }
    }
    if ((markType & CRRulerMarkTypeMinor) && (frequency > 0)) {
        if ((_spacingBetweenMarks > 0 ) || (_rulerWidth > 0)) {
            self.rulerLayer.minorMark.frequency = [NSNumber numberWithFloat:frequency].doubleValue;
            self.rulerWidth = _rulerWidth;
            self.spacingBetweenMarks = _spacingBetweenMarks;
        }
    }
    [self.rulerLayer setNeedsDisplay];
}

- (void)setTextAlignment:(CRRulerMarkAlignment)alignment forMarkType:(CRRulerMarkType)markType {
    if (markType & CRRulerMarkTypeMajor) {
        self.rulerLayer.majorMark.textAlignment = alignment;
    }
    if (markType & CRRulerMarkTypeMiddle) {
        self.rulerLayer.middleMark.textAlignment = alignment;
    }
    if (markType & CRRulerMarkTypeMinor) {
        self.rulerLayer.minorMark.textAlignment = alignment;
    }
    [self.rulerLayer setNeedsDisplay];
}

- (void)setAlignment:(CRRulerMarkAlignment)alignment forMarkType:(CRRulerMarkType)markType {
    if (markType & CRRulerMarkTypeMajor) {
        self.rulerLayer.majorMark.alignment = alignment;
    }
    if (markType & CRRulerMarkTypeMiddle) {
        self.rulerLayer.middleMark.alignment = alignment;
    }
    if (markType & CRRulerMarkTypeMinor) {
        self.rulerLayer.minorMark.alignment = alignment;
    }
    [self.rulerLayer setNeedsDisplay];
}

- (void)setTextOffset:(CGPoint)textOffset forMarkType:(CRRulerMarkType)markType {
    if (markType & CRRulerMarkTypeMajor) {
        self.rulerLayer.majorMark.textOffset = textOffset;
    }
    if (markType & CRRulerMarkTypeMiddle) {
        self.rulerLayer.middleMark.textOffset = textOffset;
    }
    if (markType & CRRulerMarkTypeMinor) {
        self.rulerLayer.minorMark.textOffset = textOffset;
    }
    [self.rulerLayer setNeedsDisplay];
}

- (void)setOffset:(CGPoint)offset forMarkType:(CRRulerMarkType)markType {
    if (markType & CRRulerMarkTypeMajor) {
        self.rulerLayer.majorMark.offset = offset;
    }
    if (markType & CRRulerMarkTypeMiddle) {
        self.rulerLayer.middleMark.offset = offset;
    }
    if (markType & CRRulerMarkTypeMinor) {
        self.rulerLayer.minorMark.offset = offset;
    }
    [self.rulerLayer setNeedsDisplay];
}

#pragma mark - Get mark type method

- (CGSize)sizeForMarkType:(CRRulerMarkType)markType {
    if (markType == CRRulerMarkTypeMajor) {
        return self.rulerLayer.majorMark.size;
    }
    if (markType == CRRulerMarkTypeMiddle) {
        return self.rulerLayer.middleMark.size;
    }
    if (markType == CRRulerMarkTypeMinor) {
        return self.rulerLayer.minorMark.size;
    }
    return CGSizeZero;
}

- (UIColor *)colorForMarkType:(CRRulerMarkType)markType {
    if (markType & CRRulerMarkTypeMajor) {
        return self.rulerLayer.majorMark.color;
    }
    if (markType & CRRulerMarkTypeMiddle) {
        return self.rulerLayer.middleMark.color;
    }
    if (markType & CRRulerMarkTypeMinor) {
        return self.rulerLayer.minorMark.color;
    }
    return nil;
}

- (UIColor *)textColorForMarkType:(CRRulerMarkType)markType {
    if (markType & CRRulerMarkTypeMajor) {
        return self.rulerLayer.majorMark.textColor;
    }
    if (markType & CRRulerMarkTypeMiddle) {
        return self.rulerLayer.middleMark.textColor;
    }
    if (markType & CRRulerMarkTypeMinor) {
        return self.rulerLayer.minorMark.textColor;
    }
    return nil;
}

- (UIFont *)fontForMarkType:(CRRulerMarkType)markType {
    if (markType & CRRulerMarkTypeMajor) {
        return self.rulerLayer.majorMark.font;
    }
    if (markType & CRRulerMarkTypeMiddle) {
        return self.rulerLayer.middleMark.font;
    }
    if (markType & CRRulerMarkTypeMinor) {
        return self.rulerLayer.minorMark.font;
    }
    return nil;
}

- (CGFloat)frequencyForMarkType:(CRRulerMarkType)markType {
    if (markType & CRRulerMarkTypeMajor) {
        return self.rulerLayer.majorMark.frequency * self.rulerLayer.minorMark.frequency;
    }
    if (markType & CRRulerMarkTypeMiddle) {
        return  self.rulerLayer.middleMark.frequency * self.rulerLayer.minorMark.frequency;
    }
    if (markType & CRRulerMarkTypeMinor) {
        return  self.rulerLayer.minorMark.frequency;
    }
    return CGFLOAT_MIN;
}

- (CRRulerMarkAlignment)textAlignmentForMarkType:(CRRulerMarkType)markType {
    if (markType & CRRulerMarkTypeMajor) {
        return self.rulerLayer.majorMark.textAlignment;
    }
    if (markType & CRRulerMarkTypeMiddle) {
        return self.rulerLayer.middleMark.textAlignment;
    }
    if (markType & CRRulerMarkTypeMinor) {
        return self.rulerLayer.minorMark.textAlignment;
    }
    return 0;
}

- (CRRulerMarkAlignment)alignmentForMarkType:(CRRulerMarkType)markType {
    if (markType & CRRulerMarkTypeMajor) {
        return self.rulerLayer.majorMark.alignment;
    }
    if (markType & CRRulerMarkTypeMiddle) {
        return self.rulerLayer.middleMark.alignment;
    }
    if (markType & CRRulerMarkTypeMinor) {
        return self.rulerLayer.minorMark.alignment;
    }
    return 0;
}

- (CGPoint)textOffsetForMarkType:(CRRulerMarkType)markType {
    if (markType & CRRulerMarkTypeMajor) {
        return self.rulerLayer.majorMark.textOffset;
    }
    if (markType & CRRulerMarkTypeMiddle) {
        return self.rulerLayer.middleMark.textOffset;
    }
    if (markType & CRRulerMarkTypeMinor) {
        return self.rulerLayer.minorMark.textOffset;
    }
    return CGPointZero;
}

- (CGPoint)offsetForMarkType:(CRRulerMarkType)markType {
    if (markType & CRRulerMarkTypeMajor) {
        return self.rulerLayer.majorMark.offset;
    }
    if (markType & CRRulerMarkTypeMiddle) {
        return self.rulerLayer.middleMark.offset;
    }
    if (markType & CRRulerMarkTypeMinor) {
        return self.rulerLayer.minorMark.offset;
    }
    return CGPointZero;
}

@end
