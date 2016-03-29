//
//  TickView.h
//  OWeather
//
//  Created by yuanyongguo on 16/3/29.
//  Copyright © 2016年 youxinpai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TickView : UIView
{
    NSInteger _groupTick;
}
@property (assign,nonatomic) NSInteger lowTick; //最小刻度值
@property (assign,nonatomic) NSInteger heightTick; //最大刻度值
@property (assign,nonatomic)  CGFloat  padding;
@property (assign,nonatomic) NSInteger groupCount; //刻度组数
@property (assign,nonatomic) NSInteger groupTick; //每一组的刻度数

@property (copy,nonatomic) UIColor * tickColor;


-(void) drawTick ;
@end
