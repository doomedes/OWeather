//
//  TemperatureView.h
//  OWeather
//
//  Created by yuanyongguo on 16/3/28.
//  Copyright © 2016年 youxinpai. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 温度计视图
 */
@interface TemperatureView : UIView
{
    //最高温度值
    CGFloat _heightTemperature;
    //最低温度值
    CGFloat _lowTemperature;
}
//温度计颜色
@property(copy,nonatomic) UIColor *fillBackColor;
//温度颜色
@property(copy,nonatomic) UIColor * fillTopColor;
//温度计的半径
@property (assign,nonatomic) CGFloat backRadius;
//当前温度值
@property (assign,nonatomic) CGFloat currentTemperature;

@property (assign,nonatomic) CGFloat lowTemperature;

@property (assign,nonatomic) CGFloat heightTemperature;

//绘制温度计外形
- (void)drawBackTemperature;

//绘制温度计当前温度
- (void)drawTopTemperature;

@end
