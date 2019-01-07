#UIImage-Helpers ![License MIT](https://go-shields.herokuapp.com/license-MIT-blue.png)

Create a blurred images, take a screenshot, make a image with color...

<p align="center">
  <img src="http://s27.postimg.org/xz5kkg5ab/UIImage_Helpers.png" alt="UIImage-Helpers" title="UIImage-Helpers" width="792" height="392">
</p>

[![Build Status](https://api.travis-ci.org/NZN/UIImage-Helpers.png)](https://api.travis-ci.org/NZN/UIImage-Helpers.png)
[![Cocoapods](https://cocoapod-badges.herokuapp.com/v/UIImage-Helpers/badge.png)](http://beta.cocoapods.org/?q=UIImage-Helpers)
[![Cocoapods](https://cocoapod-badges.herokuapp.com/p/UIImage-Helpers/badge.png)](http://beta.cocoapods.org/?q=UIImage-Helpers)
[![Analytics](https://ga-beacon.appspot.com/UA-48753665-1/NZN/UIImage-Helpers/README.md)](https://github.com/igrigorik/ga-beacon)

## Requirements

UIImage-Helpers works on iOS 5.0+ version and is compatible with ARC projects. It depends on the following Apple frameworks, which should already be included with most Xcode templates:

* Accelerate.framework
* Foundation.framework
* QuartzCore.framework

You will need LLVM 3.0 or later in order to build UIImage-Helpers.

## Adding UIImage-Helpers to your project

### Cocoapods

[CocoaPods](http://cocoapods.org) is the recommended way to add UIImage-Helpers to your project.

* Add a pod entry for UIImage-Helpers to your Podfile:

```
pod 'UIImage-Helpers'
```

* Install the pod(s) by running:

```
pod install
```

### Source files

Alternatively you can directly add source files to your project.

1. Download the [latest code version](https://github.com/NZN/UIImage-Helpers/archive/master.zip) or add the repository as a git submodule to your git-tracked project.
2. Open your project in Xcode, then drag and drop all files at `UIImage-Helpers` folder onto your project (use the "Product Navigator view"). Make sure to select Copy items when asked if you extracted the code archive outside of your project.

## Usage

* Make a blurred image with another image

```objective-c
#import "UIImage+Blur.h"
...

// jpeg quality image data
float quality = .00001f;

// intensity of blurred
float blurred = .5f;
    
NSData *imageData = UIImageJPEGRepresentation([self.imageViewNormal image], quality);
UIImage *blurredImage = [[UIImage imageWithData:imageData] blurredImage:blurred];
self.imageViewBlurred.image = blurredImage;
```

* Take a screenshot

```objective-c
#import "UIImage+Screenshot.h"
...

UIImage *image = [UIImage screenshot];
self.imageView.image = image;
```

* Generate a image with color

```objective-c
#import "UIImage+ImageWithColor.h"
...
UIColor *purpleColor = [UIColor colorWithRed:.927f green:.264f blue:.03f alpha:1];
UIImage *image = [UIImage imageWithColor:purpleColor];
    
[self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
```

## License

This code is distributed under the terms and conditions of the [MIT license](LICENSE).

## Change-log

A brief summary of each UIImage-Helpers release can be found on the [wiki](https://github.com/NZN/UIImage-Helpers/wiki/Change-log).

## To-do Items

- Category for crop images
