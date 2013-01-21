//
//  PDCViewController.h
//  blinker
//
//  Created by koba on 1/21/13.
//  Copyright (c) 2013 Pas de Chocolat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDCBlinker.h"

@interface PDCViewController : UIViewController <PDCBlinkerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
