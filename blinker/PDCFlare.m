//
//  PDCFlare.m
//  designschoolcheats
//
//  Created by koba on 1/15/13.
//  Copyright (c) 2013 Pas de Chocolat, LLC. All rights reserved.
//

#import "PDCFlare.h"

#define PDC_DSC_SHINY_CLEAN_FLARE_RADIUS_MIN 1.0f
#define PDC_DSC_SHINY_CLEAN_FLARE_RADIUS_MAX 3.0f

@implementation PDCFlare

- (id)init
{
    self = [super init];
    if (self) {
        _minimumRadius = PDC_DSC_SHINY_CLEAN_FLARE_RADIUS_MIN;
        _maximumRadius = PDC_DSC_SHINY_CLEAN_FLARE_RADIUS_MAX;
        _center = CGPointMake(100.0f, 100.0f);
    }
    return self;
}

- (CIImage *)flareImageAtPercentComplete:(CGFloat)percentComplete
{
    CIFilter *lensFilter = [self.delegate flare:self filterAtPercentComplete:percentComplete];
    CIImage *lensFlareImage = lensFilter.outputImage;
    CIFilter *cropFilter = [self.delegate flare:self cropFilterWithInputImage:lensFlareImage];
    return cropFilter.outputImage;
}

@end
