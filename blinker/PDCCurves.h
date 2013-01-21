//
//  PDCCurves.h
//  designschoolcheats
//
//  Created by koba on 1/6/13.
//  Copyright (c) 2013 Pas de Chocolat, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDCCurves : NSObject

+ (CGFloat)cubicEaseInOutAtPercentComplete:(CGFloat)t start:(CGFloat)start end:(CGFloat)end;
+ (CGFloat)quarticEaseInOutAtPercentComplete:(CGFloat)t start:(CGFloat)start end:(CGFloat)end;
+ (CGFloat)quadraticEaseInOutAtPercentComplete:(CGFloat)t start:(CGFloat)start end:(CGFloat)end;
+ (CGFloat)sinusoidalEaseInOutAtPercentComplete:(CGFloat)t start:(CGFloat)start end:(CGFloat)end;

@end
