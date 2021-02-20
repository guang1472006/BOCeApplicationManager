AEGuideView
============
 
An easy way to let your app show guide view during startup. This framework is inspired from ![HcdGuideView](https://github.com/Jvaeyhcd/HcdGuideView).
This framework overcomes the problem that sometimes HcdGuideView doesn't show at all when app starts up. And this framework has be rewritten to have it comform to auto layout design.

<br />

![AEGuideView](https://dl.dropboxusercontent.com/u/73895323/AEGuideView-GitHub.png)


<br />
## Installation

### From CocoaPods

* Add `pod 'AEGuideView', '~> 1.0.1'` to your Podfile.
* Install by running `pod install`
* Include AEGuideView by adding `#import <AEGuideView/AEGuideView.h>`

## Usage

(see sample Xcode project in `/AEGuideViewDemo`)

AEGuideView is created as a singleton (i.e. it doesn't need to be explicitly allocated and instantiated; you get its instace by calling `[AEGuideView instance]`).

### Showing the AEGuideView

You can show the AEGuideView:

```objective-c
   NSMutableArray *images = [NSMutableArray new];
    
    [images addObject:[UIImage imageNamed:@"1"]];
    [images addObject:[UIImage imageNamed:@"2"]];
    [images addObject:[UIImage imageNamed:@"3"]];
  
    
    AEGuideView *guideView = [AEGuideView instance];
    
    __weak AppDelegate* weakDelegate = self;
    [guideView showGuideViewWithImages:images
                        andButtonTitle:@"立即体验"
                   andButtonTitleColor:[UIColor whiteColor]
                      andButtonBGColor:[UIColor clearColor]
                  andButtonBorderColor:[UIColor whiteColor]
                   withCompletionBlock:^(void){
                       
                       [weakDelegate.window makeKeyWindow];
                   }];
```


#### Customization - tweak the bottom spaces for last step button and page control
```objective-c
    //Define bottom spaces prior to showing the AEGuideView
    [AEGuideView appearance].pageControlBottomSpace = @(0);
    [AEGuideView appearance].lastButtonBottmSpace = @(40);
  }];
```

**Default bottom spaces**
```objective-c
#define kAEGuideView_DefaultPageControlBottomSpace  20
#define KAEGuideView_DefaultLastButtonBottomSpace   60
```


## Credits

AEGuideView is brought to you by [**William Wangi**](https://github.com/canicelebrate). If you have feature suggestions or bug reports, feel free to help out by sending pull requests or by [creating new issues](https://github.com/canicelebrate/AEGuideView/issues/new). If you're using AEGuideView in your project, attribution would be nice.


