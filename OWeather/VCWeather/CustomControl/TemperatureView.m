//
//  TemperatureView.m
//  OWeather
//
//  Created by yuanyongguo on 16/3/28.
//  Copyright © 2016年 youxinpai. All rights reserved.
//

#import "TemperatureView.h"

@interface TemperatureView ()

@property (strong,nonnull) CAShapeLayer *backTemptureLayer;
@property (strong,nonnull) CAShapeLayer *topTemptureLayer;

@end

@implementation TemperatureView

#pragma  mark-属性

-(CGFloat)heightTemperature {
    if(_heightTemperature<=_lowTemperature) {
        _heightTemperature=50;
    }
    return _heightTemperature;
}

-(void)setHeightTemperature:(CGFloat)heightTemperature {
    if(heightTemperature<=_lowTemperature) {
        return;
    }
     _heightTemperature=heightTemperature;
}


-(CGFloat)lowTemperature{
    if(_heightTemperature<=_lowTemperature) {
        _lowTemperature=0;
    }
    return _lowTemperature;
}

-(void)setLowTemperature:(CGFloat)lowTemperature {
    if(_heightTemperature<=lowTemperature) {
        return;
    }
     _lowTemperature=lowTemperature;
}

-(void)setCurrentTemperature:(CGFloat)currentTemperature {
    if(currentTemperature<self.lowTemperature||currentTemperature>self.heightTemperature){
        return;
    }
    _currentTemperature=currentTemperature;
        [self drawTopTemperature];
}

-(void)setFillBackColor:(UIColor *)fillBackColor {
    self.backTemptureLayer.fillColor=fillBackColor.CGColor;
    _fillBackColor=fillBackColor;
}

-(void)setFillTopColor:(UIColor *)fillTopColor {
    self.topTemptureLayer.fillColor=fillTopColor.CGColor;
    _fillTopColor=fillTopColor;
}

#pragma  mark-事件

-(instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if(self){
        self.backTemptureLayer=[[CAShapeLayer alloc]init];
        self.topTemptureLayer=[[CAShapeLayer alloc]init];
        [self.layer addSublayer:self.backTemptureLayer];
        [self.layer addSublayer:self.topTemptureLayer];
    }
    return self;
}

- (void)drawBackTemperature {
    NSInteger width=self.bounds.size.width;;
    NSInteger height=self.bounds.size.height;
    NSInteger radius=self.backRadius;
    CGPoint topCenter=CGPointMake(width/2,  radius);
    CGPoint buttomCenter=CGPointMake(width/2, height-2*radius);
    
    self.backTemptureLayer.frame=self.bounds;
//    self.backTemptureLayer.fillColor=self.fillBackColor.CGColor;
    
    UIBezierPath *path=[[UIBezierPath alloc]init];
    [path  moveToPoint:CGPointMake(width/2-radius,  radius)];
    [path addArcWithCenter:topCenter radius: radius startAngle:M_PI endAngle:2*M_PI clockwise:YES];
    [path addLineToPoint:CGPointMake(width/2+radius, height-cos(M_PI/6)*radius*2-2*radius)];
    [path addArcWithCenter:buttomCenter radius:2*radius startAngle:-M_PI/3 endAngle:M_PI+M_PI/3 clockwise:YES];
    [path closePath];
    
    self.backTemptureLayer.path=path.CGPath;
    [self.backTemptureLayer setNeedsDisplay];
    
}

- (void)drawTopTemperature {
    
    NSInteger width=self.bounds.size.width;;
    NSInteger height=self.bounds.size.height;
    CGFloat radius=self.backRadius*0.75;
    CGPoint buttomCenter=CGPointMake(width/2, height-2*self.backRadius);
    //底部圆的高度
    CGFloat buttomArcHeight=cos(M_PI/6)*self.backRadius*2+2*self.backRadius;
    
    //根据当前温度计算温度计的高度（总高度－backlayer底部圆的高度－backlayer顶部圆的高度－toplayer顶部圆的高度）
    CGFloat disHeight=(height-buttomArcHeight-self.backRadius-radius)*(self.currentTemperature-self.lowTemperature)/(self.heightTemperature-self.lowTemperature);
    
    //顶部圆的中心
    CGPoint topCenter=CGPointMake(width/2, height- disHeight-buttomArcHeight);
    CGFloat startPointY=(height-buttomArcHeight);
    
    self.topTemptureLayer.frame=self.bounds;
//    self.topTemptureLayer.fillColor=self.fillTopColor.CGColor;
    
    UIBezierPath *path=[[UIBezierPath alloc]init];
    //底部圆的右边作为起点
    [path  moveToPoint:CGPointMake(width/2+radius, startPointY)];
    [path addArcWithCenter:buttomCenter radius:2*radius startAngle:-M_PI/3 endAngle:M_PI+M_PI/3 clockwise:YES];
    [path addLineToPoint:CGPointMake(width/2-radius, height- disHeight-buttomArcHeight)];
    [path addArcWithCenter:topCenter radius: radius startAngle:M_PI endAngle:2*M_PI clockwise:YES];
    [path closePath];
    self.topTemptureLayer.path=path.CGPath;
    [self.topTemptureLayer setNeedsDisplay];
}

@end
