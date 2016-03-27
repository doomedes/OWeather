//
//  AppDelegate.m
//  OWeather
//
//  Created by yuanyongguo on 16/3/25.
//  Copyright © 2016年 youxinpai. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "LocationViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma  mark- 属性



#pragma mark- 事件

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.managerQueue=[[BasicRequestManagerQueue alloc]initWithUrlString:cityListURL];
    
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self showHomeWeather];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark-自定义相关方法

-(void) showHomeWeather {
    
    //如果有VC则先dismiss
    if(self.window.rootViewController){
        if(self.window.rootViewController.presentedViewController){
            [self.window.rootViewController.presentedViewController dismissViewControllerAnimated:YES completion:nil];
        }
    }
    
    if(![LocationOperation defaultLocationOperation].currentCityName||[LocationOperation defaultLocationOperation].currentCityName.length==0){
        LocationViewController  *locationVC=[[LocationViewController alloc]init];
        self.window.rootViewController=locationVC;
    }else{
        
        HomeViewController *rootController=[[HomeViewController alloc]init];
        self.window.rootViewController=rootController;
    }
}

@end
