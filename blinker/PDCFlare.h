//
//  PDCFlare.h
//  designschoolcheats
//
//  Created by koba on 1/15/13.
//  Copyright (c) 2013 Pas de Chocolat, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDCFlareDelegate.h"

@interface PDCFlare : NSObject

@property (nonatomic, weak) id <PDCFlareDelegate> delegate;
@property (nonatomic, assign) CGFloat minimumRadius;
@property (nonatomic, assign) CGFloat maximumRadius;
@property (nonatomic, assign) CGPoint center;

- (CIImage *)flareImageAtPercentComplete:(CGFloat)percentComplete;

@end
