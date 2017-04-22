//
//  TTAOPAppDelegate.m
//  Pods
//
//  Created by apple on 2017/4/13.
//
//

#import "TTAOPAppDelegate.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import "TTSDKMacros.h"

@implementation TTAOPAppDelegate

+(void)load
{
    
    TTAppDelegateName(@"AppDelegate")
    TTdifferentClassExchangeMethod(@"application:didFinishLaunchingWithOptions:",didFinishLaunching,TTAOP_application:didFinishLaunchingWithOptions:)
    
    
}

- (BOOL)TTAOP_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    
    
    
    
    
    
    
    return [self TTAOP_application:application didFinishLaunchingWithOptions:launchOptions];
}


@end
