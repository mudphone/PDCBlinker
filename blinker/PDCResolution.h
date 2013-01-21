//
//  PDCResolution.h
//  designschoolcheats
//
//  Created by koba on 10/20/12.
//  Copyright (c) 2012 Pas de Chocolat, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

enum {
    PDCDeviceResolutionIPhoneStandardRes      = 1,    // iPhone 1,3,3GS Standard Resolution   (320x480px)
    PDCDeviceResolutionIPhoneHiRes            = 2,    // iPhone 4,4S High Resolution          (640x960px)
    PDCDeviceResolutionIPhoneTallerHiRes      = 3,    // iPhone 5 High Resolution             (640x1136px)
    PDCDeviceResolutionIPadStandardRes        = 4,    // iPad 1,2 Standard Resolution         (1024x768px)
    PDCDeviceResolutionIPadHiRes              = 5     // iPad 3 High Resolution               (2048x1536px)
}; typedef NSUInteger PDCDeviceResolution;

@interface PDCResolution : NSObject

+ (CGSize)screenSize;
+ (CGFloat)scale;
+ (PDCDeviceResolution)deviceResolution;

@end
