//
//  AppDelegate.m
//  RT_App_Test
//
//  Created by Sergey Yefanov on 15.08.15.
//  Copyright (c) 2015 Sergey Yefanov. All rights reserved.
//

#import "ERTAppDelegate.h"
#import "ERTNetworkManager.h"

@implementation ERTAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [ERTNetworkManager initRestKit];
    return YES;
}

@end
