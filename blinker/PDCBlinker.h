//
//  PDCBlinker.h
//  designschoolcheats
//
//  Created by koba on 1/21/13.
//  Copyright (c) 2013 Pas de Chocolat, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDCBlinkerDelegate.h"
#import "PDCFlareDelegate.h"

@interface PDCBlinker : NSObject <PDCFlareDelegate>

@property (nonatomic, weak) id <PDCBlinkerDelegate> delegate;
@property (nonatomic, assign) CGFloat flaringDuration;
@property (nonatomic, assign) CGSize cropSize;

- (id)initWithFlareCount:(NSUInteger)flareCount cropSize:(CGSize)cropSize backgroundImage:(CIImage *)backgroundImage;

- (void)primeFlares;
- (void)startFlares;
- (void)cancelFlares;

@end
