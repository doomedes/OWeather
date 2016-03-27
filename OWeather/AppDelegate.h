//
//  AppDelegate.h
//  OWeather
//
//  Created by yuanyongguo on 16/3/25.
//  Copyright © 2016年 youxinpai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicRequestManagerQueue.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong,nonatomic) BasicRequestManagerQueue * managerQueue;

-(void) showHomeWeather;

@end

