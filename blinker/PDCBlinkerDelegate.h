//
//  PDCBlinkerDelegate.h
//  designschoolcheats
//
//  Created by koba on 1/21/13.
//  Copyright (c) 2013 Pas de Chocolat, LLC. All rights reserved.
//

@class PDCBlinker;
#import "PDCFlare.h"

@protocol PDCBlinkerDelegate <NSObject>

- (void)blinker:(PDCBlinker *)blinker updatedImage:(UIImage *)image;

@optional
- (void)blinker:(PDCBlinker *)blinker willConfigureFlare:(PDCFlare *)flare atIndex:(NSUInteger)index;

@end
