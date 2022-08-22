//
//  AppDelegate.m
//  CodeWithNoScene
//
//  Created by yuhua Tang on 2022/8/19.
//  Copyright © 2022 pencilCool. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
@import TYHWaterMark;
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    self.window.rootViewController = nav;
    [self.window addSubview:[TYHWaterMarkView new]];
    [self.window makeKeyAndVisible];
    
    return YES;
}



@end
