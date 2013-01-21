//
//  PDCFlareDelegate.h
//  designschoolcheats
//
//  Created by koba on 1/15/13.
//  Copyright (c) 2013 Pas de Chocolat, LLC. All rights reserved.
//

@class PDCFlare;

@protocol PDCFlareDelegate <NSObject>

- (CIFilter *)flare:(PDCFlare *)flare filterAtPercentComplete:(CGFloat)percentComplete;
- (CIFilter *)flare:(PDCFlare *)flare cropFilterWithInputImage:(CIImage *)inputImage;

@end
