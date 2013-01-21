//
//  PDCViewController.m
//  blinker
//
//  Created by koba on 1/21/13.
//  Copyright (c) 2013 Pas de Chocolat. All rights reserved.
//

#import "PDCViewController.h"
#import "PDCResolution.h"

@interface PDCViewController ()
@property (nonatomic, strong) PDCBlinker *blinker;

- (void)startFlares;
@end

@implementation PDCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Get background image:
    NSString *imageName = @"42-illus-568h@2x";
    if ([PDCResolution deviceResolution] == PDCDeviceResolutionIPhoneStandardRes) {
        imageName = @"42-illus";
    } else if ([PDCResolution deviceResolution] == PDCDeviceResolutionIPhoneHiRes) {
        imageName = @"42-illus@2x";
    }
    NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
    CIImage *backgroundImage = [CIImage imageWithContentsOfURL:[NSURL fileURLWithPath:filePath]];
    
    // Create blinker:
    self.blinker = [[PDCBlinker alloc] initWithFlareCount:2
                                                 cropSize:self.view.bounds.size
                                          backgroundImage:backgroundImage];
    self.blinker.delegate = self;
    
    // Prime flares:
    UIImage *origImage = self.imageView.image;
    [self.blinker primeFlares];
    self.imageView.image = origImage;
    
    // Animate flares after delay
    [self performSelector:@selector(startFlares) withObject:nil afterDelay:2.0f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startFlares
{
    [self.blinker startFlares];
}


#pragma mark - Blinker Delegate Methods

- (void)blinker:(PDCBlinker *)blinker updatedImage:(UIImage *)image
{
    self.imageView.image = image;
}

@end
