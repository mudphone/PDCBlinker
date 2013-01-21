//
//  PDCResolution.m
//  designschoolcheats
//
//  Created by koba on 10/20/12.
//  Copyright (c) 2012 Pas de Chocolat, LLC. All rights reserved.
//

#import "PDCResolution.h"

@interface PDCResolution ()
+ (CGSize)scaledSize;
@end

@implementation PDCResolution

+ (CGSize)screenSize
{
    return [[UIScreen mainScreen] bounds].size;
}

+ (CGSize)scaledSize
{
    CGSize result = [self screenSize];
    return CGSizeMake(result.width  * [UIScreen mainScreen].scale,
                      result.height * [UIScreen mainScreen].scale);
}

+ (CGFloat)scale
{
    CGFloat s = 1.0f;
    if ([[UIScreen mainScreen] respondsToSelector: @selector(scale)]) {
        s = [UIScreen mainScreen].scale;
    }
    return s;
}

+ (PDCDeviceResolution) deviceResolution {
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        // This is an iPhone.
        if ([[UIScreen mainScreen] respondsToSelector: @selector(scale)]) {
            CGFloat scaledHeight = [self scaledSize].height;
            if (scaledHeight == 480) return PDCDeviceResolutionIPhoneStandardRes;
            return (scaledHeight == 960 ? PDCDeviceResolutionIPhoneHiRes : PDCDeviceResolutionIPhoneTallerHiRes);
            
        } else {
            return PDCDeviceResolutionIPhoneStandardRes;
        }
        
    } else {
        // This is an iPad.
        // iPads g1 and g2 resopond to "scale" as of iOS 4.
        if ([[UIScreen mainScreen] respondsToSelector: @selector(scale)]) {
            if ([self scaledSize].height == 1024) return PDCDeviceResolutionIPadStandardRes;
            return PDCDeviceResolutionIPadHiRes;
            
        } else
            return PDCDeviceResolutionIPadStandardRes;
    }
}

@end
