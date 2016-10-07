//
//  CRRulerLayer.h
//  Pods
//
//  Created by Sergey Chuchukalo on 08/25/2016.
//
//  Copyright © 2016 Cleveroad Inc. All rights reserved.

#import <QuartzCore/QuartzCore.h>
#import "CRMark.h"

@interface CRRulerLayer : CALayer

typedef struct CRRange {
    CGFloat location;
    CGFloat length;
} CRRange;

@property (nonatomic) CRRange rulerRange;

@property (nonatomic) CRMark *minorMark;
@property (nonatomic) CRMark *middleMark;
@property (nonatomic) CRMark *majorMark;

@end