//
//  AppDelegate.m
//  StoryBoardWithNoScene
//
//  Created by yuhua Tang on 2022/8/20.
//  Copyright © 2022 pencilCool. All rights reserved.
//

#import "AppDelegate.h"
@import TYHWaterMark;
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self.window addSubview:[TYHWaterMarkView new]];
    return YES;
}

@end
