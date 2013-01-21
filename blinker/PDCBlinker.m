//
//  PDCBlinker.m
//  designschoolcheats
//
//  Created by koba on 1/21/13.
//  Copyright (c) 2013 Pas de Chocolat, LLC. All rights reserved.
//

#import "PDCBlinker.h"
#import "PDCCurves.h"
#import "PDCFlare.h"
#import "PDCResolution.h"


@interface PDCBlinker ()
@property (nonatomic, strong) CIImage *backgroundImage;
@property (nonatomic, strong) CIContext *context;
@property (nonatomic, strong) CIFilter *lensFilter;
@property (nonatomic, strong) CIFilter *cropFilter;
@property (nonatomic, strong) CIFilter *compositeFilter;

@property (nonatomic, assign) NSUInteger flareCount;
@property (nonatomic, assign) NSTimeInterval startTimeInterval;
@property (nonatomic, strong) NSTimer *flareTimer;
@property (nonatomic, strong) NSMutableArray *flares;

- (void)createFlares;

- (void)updateFlaresAtPercentComplete:(CGFloat)percentComplete;
- (void)updateFlares;

- (CIFilter *)compositeFilterWithInputImage:(CIImage *)inputImage backgroundImage:(CIImage *)backgroundImage;
@end

@implementation PDCBlinker

- (id)initWithFlareCount:(NSUInteger)flareCount cropSize:(CGSize)cropSize backgroundImage:(CIImage *)backgroundImage
{
    self = [super init];
    if (self) {
        _flareCount = flareCount;
        _cropSize = cropSize;
        _backgroundImage = backgroundImage;
        
        _flaringDuration = 1.0f; // in seconds
        _flares = [NSMutableArray arrayWithCapacity:_flareCount];
    }
    return self;
}

- (CIContext *)context
{
    if (_context != nil) return _context;
    _context = [CIContext contextWithOptions:nil];
    return _context;
}

- (void)dealloc
{
    [self cancelFlares];
}


#pragma mark - Startup

- (void)primeFlares
{
    self.context = [CIContext contextWithOptions:nil];
    [self createFlares];
    [self updateFlaresAtPercentComplete:0.0f];
}

- (void)createFlares
{
    for (int i=0; i<self.flareCount; i++) {
        PDCFlare *flare = [[PDCFlare alloc] init];
        flare.delegate = self;
        
        // Position the flares:
        if (i==1) {
            flare.center = CGPointMake(200.0f, 200.0f);
            flare.maximumRadius *= 1.5f;
        }
        
        [self.flares addObject:flare];
    }
}

- (void)startFlares
{
    // Create flares:
    if ([self.flares count]==0) [self createFlares];
    
    // Cancel if no flares:
    if ([self.flares count] == 0) return;
    
    // Create a baseline timer marker:
    self.startTimeInterval = [NSDate timeIntervalSinceReferenceDate];
    [self updateFlaresAtPercentComplete:0.0f];
    
    // Start timer:
    self.flareTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f/30.0f
                                                       target:self
                                                     selector:@selector(updateFlares)
                                                     userInfo:nil
                                                      repeats:YES];
}

- (void)cancelFlares
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startFlares) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(updateFlares) object:nil];
    [self.flareTimer invalidate];
    [self.flares removeAllObjects];
}


#pragma mark - Update

- (void)updateFlaresAtPercentComplete:(CGFloat)percentComplete
{
    // Get lens flare image based on progression of timed animation sequence (% as float):
    CIImage *allFlaresImage;
    for (PDCFlare *flare in self.flares) {
        CIImage *flareImage = [flare flareImageAtPercentComplete:percentComplete];
        if (allFlaresImage == nil) {
            allFlaresImage = flareImage;
        } else {
            allFlaresImage = [self compositeFilterWithInputImage:flareImage
                                                 backgroundImage:allFlaresImage].outputImage;
        }
    }
    
    // Add background image:
    CIImage *outputImage = [self compositeFilterWithInputImage:allFlaresImage
                                               backgroundImage:self.backgroundImage].outputImage;
    
    // Swap in new image:
    CGImageRef cgimg = [self.context createCGImage:outputImage
                                          fromRect:[outputImage extent]];
    if (self.delegate && [self.delegate respondsToSelector:@selector(blinker:updatedImage:)]) {
        [self.delegate blinker:self
                  updatedImage:[[UIImage alloc] initWithCGImage:cgimg
                                                          scale:[PDCResolution scale]
                                                    orientation:UIImageOrientationUp]];
    }
    
    // Release it:
    CGImageRelease(cgimg);
    
    // Complete!
    if (percentComplete >= 1.0f) {
        [self cancelFlares];
    }
}

- (void)updateFlares
{
    CGFloat t = [NSDate timeIntervalSinceReferenceDate] - self.startTimeInterval;
    CGFloat pctComplete = t / self.flaringDuration;
    pctComplete = MAX( 0.0f, MIN( 1.0f, pctComplete ) );
    [self updateFlaresAtPercentComplete:pctComplete];
}


#pragma mark - Flare Filters

- (CIFilter *)compositeFilterWithInputImage:(CIImage *)inputImage backgroundImage:(CIImage *)backgroundImage
{
    if (_compositeFilter == nil) {
        _compositeFilter = [CIFilter filterWithName:@"CILightenBlendMode"
                                      keysAndValues:
                            @"inputImage", inputImage,
                            @"inputBackgroundImage", backgroundImage,
                            nil];
    } else {
        [self.compositeFilter setValue:inputImage      forKey:@"inputImage"];
        [self.compositeFilter setValue:backgroundImage forKey:@"inputBackgroundImage"];
    }
    
    return _compositeFilter;
}


#pragma mark - Flare Delegates

// Center parameter is in UIKit coordinate system.
- (CIFilter *)flare:(PDCFlare *)flare filterAtPercentComplete:(CGFloat)percentComplete
{
    CGFloat scale = [PDCResolution scale];
    CGFloat minR = flare.minimumRadius;
    CGFloat maxR = flare.maximumRadius;
    minR *= scale;
    maxR *= scale;
    
    // Use fancy curve:
    CGFloat radius = [PDCCurves sinusoidalEaseInOutAtPercentComplete:percentComplete start:minR end:maxR];
    
    CGFloat height = self.cropSize.height;
    CGPoint center = flare.center;
    center.x *= scale;
    center.y *= scale;
    height   *= scale;
    
    // Translate from UIKit to CoreImage coordinate system:
    CGAffineTransform transform = CGAffineTransformMakeScale(1, -1);
    transform = CGAffineTransformTranslate(transform, 0, -height);
    center = CGPointApplyAffineTransform(center, transform);
    
    if (_lensFilter == nil) {
        
        _lensFilter = [CIFilter filterWithName:@"CIStarShineGenerator"
                                 keysAndValues:
                       @"inputColor", [CIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f],
                       @"inputRadius", @(radius),
                       @"inputCenter", [CIVector vectorWithX:center.x Y:center.y],
                       nil];
    } else {
        [_lensFilter setValue:@(radius) forKey:@"inputRadius"];
        [_lensFilter setValue:[CIVector vectorWithX:center.x Y:center.y] forKey:@"inputCenter"];
    }
    return _lensFilter;
}

- (CIFilter *)flare:(PDCFlare *)flare cropFilterWithInputImage:(CIImage *)inputImage
{
    if (_cropFilter == nil) {
        CGRect cropRect = CGRectZero;
        cropRect.size = self.cropSize;
        
        CGFloat scale = [PDCResolution scale];
        cropRect.size.width  *= scale;
        cropRect.size.height *= scale;
        
        _cropFilter = [CIFilter filterWithName:@"CICrop"
                                 keysAndValues:
                       @"inputImage", inputImage,
                       @"inputRectangle", [CIVector vectorWithCGRect:cropRect],
                       nil];
    } else {
        [self.cropFilter setValue:inputImage forKey:@"inputImage"];
    }
    return _cropFilter;
}

@end
