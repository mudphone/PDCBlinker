//
//  PDCBlinkerDelegate.h
//  designschoolcheats
//
//  Created by koba on 1/21/13.
//  Copyright (c) 2013 Pas de Chocolat, LLC. All rights reserved.
//

@class PDCBlinker;

@protocol PDCBlinkerDelegate <NSObject>

- (void)blinker:(PDCBlinker *)blinker updatedImage:(UIImage *)image;

@end
