//
//  CurveView.h
//  OWeather
//
//  Created by yuanyongguo on 16/3/29.
//  Copyright © 2016年 youxinpai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurveView : UIView

@property(assign,nonatomic) CGFloat padding;
@property (copy,nonatomic) NSArray * datas;
@property (assign,nonatomic) CGFloat maxData;
-(void) drawCure;

@end
