//
//  NSObject+ExtendInfo.m
//  OWeather
//
//  Created by 袁永国 on 16/3/26.
//  Copyright © 2016年 youxinpai. All rights reserved.
//

#import "NSObject+ExtendInfo.h"

@implementation NSObject (ExtendInfo)

-(CGFloat)currentScreenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

-(CGFloat)currentScreenHeight{
    return [UIScreen mainScreen].bounds.size.height;
}

-(CGSize)currentScreenSize {
    return [UIScreen mainScreen].bounds.size;
}


@end
