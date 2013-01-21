PDCBlinker - A CoreImage blink tag.
===================================

Requirements
------------
- CoreImage framework (add it to your Xcode project)
- PDCCurves.h/m  
A library of timing curves.
- PDCFlare.h/m  
A super-lightweight class for saving lensflare metadata (Yes, it could/should probably be refactored into an NSDictionary.)
- PDCResolution.h/m  
A class which detects screen size, scale, dimensions.

Setup
-----
Check out the included sample project (blinker.xcodeproj), as all requirements and setup code is included.  
Run the sample project for a simple example.

How do I use it?
----------------
Do this to setup a simple flare:
```
self.blinker = [[PDCBlinker alloc] initWithFlareCount:1
                                             cropSize:self.view.bounds.size
                                      backgroundImage:[self someCoreImage]];
self.blinker.delegate = self;
[self.blinker startFlares];
```

You also need to implement some delegate methods:
```
- (void)blinker:(PDCBlinker *)blinker updatedImage:(UIImage *)image
{
    self.imageView.image = image;
}

- (void)blinker:(PDCBlinker *)blinker willConfigureFlare:(PDCFlare *)flare atIndex:(NSUInteger)index
{
	\\ Customize the flare here.
}
```

